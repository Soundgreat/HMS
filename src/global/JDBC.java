package global;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

import customer.RoomBean;

public class JDBC {
	/**
	 * 	ENUMS
	 */
	private static final ArrayList<String> STAFF_ROLES = new ArrayList<String>(Arrays.asList("经理", "前台"));
	
	/**
	 * Connection
	 * @param sc
	 * @return
	 */
	public static Connection getConnection(ServletContext sc) {
		Context ctx = null;
        try {
            ctx = new InitialContext();
        } catch (NamingException e) {
            return null;
        }
        Connection cn = null;
        try {
            DataSource ds = (DataSource)sc.getAttribute("dataSource");
            if (ds == null) {
            	ds = (DataSource)ctx.lookup("java:comp/env/jdbc/HMS");
            	sc.setAttribute("dataSource", ds);
            }
            cn = ds.getConnection();
        } catch (NamingException e) {
        	// pass
        } catch (SQLException e) {
        	// pass
        }
        return cn;
	}
	
	/**
	 * Query
	 * @param cn
	 * @return
	 */
	public static String[] getDataTypes(Connection cn, String table) {
		ArrayList<String> dataTypes = new ArrayList<String>();
		try {
			String sql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ? AND TABLE_SCHEMA = 'hms'; ";
			PreparedStatement st = cn.prepareStatement(sql);
			st.setString(1, table);
			ResultSet rs = st.executeQuery();
			while (rs.next()) dataTypes.add(rs.getString(1));
			rs.close();
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dataTypes.toArray(new String[dataTypes.size()]);
	}
	
	public static String[] getTables(ServletContext sc) {
		ArrayList<String> tables = new ArrayList<String>();
		try {
			String sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'hms'; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				if (!rs.getString(1).equals("住客_订单")) tables.add(rs.getString(1));	
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return tables.toArray(new String[tables.size()]);
	}
	
	public static String[] getFields(ServletContext sc, String table) {
		ArrayList<String> fields = new ArrayList<String>();
		try {
			String sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ? AND TABLE_SCHEMA = 'hms'; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			st.setString(1, table);
			ResultSet rs = st.executeQuery();
			while (rs.next()) fields.add(rs.getString(1));
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			// pass
		}
		return fields.toArray(new String[fields.size()]);
	}
	
	public static String[] getSingleFieldValue(ServletContext sc, String table, String field, String key, String value) {
		ArrayList<String> result = new ArrayList<String>();
		try {
			String sql = "SELECT " + field + " FROM " + table + " WHERE " + key + " = ?; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			String[] fileds = getFields(sc, table);
			String[] dataTypes = getDataTypes(cn, table);
			String dataType = null;
			for(int i = 0; i < fileds.length; i++) {
				if (fileds[i].equals(key)) {
					dataType = dataTypes[i];
					break;
				}
			}
			if (setData(st, dataType, 1, value) == 1) {
				ResultSet rs = st.executeQuery();
				while (rs.next()) {
					result.add(rs.getString(1));
				}
			}
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return result.toArray(new String[result.size()]);
	}
	public static ArrayList<String> getRoomTypes(ServletContext sc) {
		ArrayList<String> roomTypes = new ArrayList<String>();
		Connection cn = JDBC.getConnection(sc);
		String sql = "SELECT 类型  FROM 客房类型;";
		try {
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				roomTypes.add(rs.getString("类型"));
			}
            rs.close();
			st.close();
            cn.close();
		} catch (SQLException e) {
			// pass
		}
		return roomTypes;
	}
	
	public static String[][] queryDirectly(ServletContext sc, String table, String field, String queryValue){
		String[][] result = null;
		try {
			String sql = "SELECT * FROM " + table + "  WHERE " + field + " LIKE '%" + queryValue + "%'; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			int rowNum = 0;
			while (rs.next()) rowNum++;
			int colNum = rs.getMetaData().getColumnCount();
			result = new String[rowNum+1][colNum];
			result[0] = JDBC.getFields(sc, table);
			for (int row = 1; row <= rowNum; row++) {
				rs.absolute(row);
				for(int col = 0; col < colNum; col++) result[row][col] = rs.getString(col+1);
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			
		}
		return result;
	}

	public static String[][] querySpecificOrder(ServletContext sc, String table, String field, String queryValue){
		String[][] result = null;
		try {
			String referencedTable = "订单";
			String sql = "SELECT * FROM " + referencedTable + " NATURAL JOIN " + table + " WHERE " + field + " LIKE '%" + queryValue + "%'; "; 
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			int rowNum = 0;
			while (rs.next()) rowNum++;
			int colNum = rs.getMetaData().getColumnCount();
			result = new String[rowNum+1][colNum];
			result[0] = JDBC.getFields(sc, referencedTable);
			for (int row = 1; row <= rowNum; row++) {
				rs.absolute(row);
				for(int col = 0; col < colNum; col++) result[row][col] = rs.getString(col+1);
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * Delete
	 * @param sc
	 * @param table
	 * @param primaryKey
	 * @param keyValue
	 * @return
	 */
	public static int deleteRow(ServletContext sc, String table, String primaryKey, String keyValue) {
		int status = 0;
		try {
			String sql = "DELETE FROM " + table + " WHERE " + primaryKey + " = " + keyValue + "; ";
			Connection cn= getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			status = st.executeUpdate();
			st.close();
			cn.close();
		} catch (SQLException e) {
			// pass
		}
		return status;
	}
	
	/**
	 * Insert
	 * @param sc
	 * @param role
	 * @return
	 */
	public static String getStaffid(ServletContext sc, String role) {
		Integer roleid = STAFF_ROLES.indexOf(role);
		String newStaffid = null;
		try {
			Connection cn = getConnection(sc);
			String sql = "SELECT 员工号 FROM 员工  WHERE 员工号  LIKE ?; ";
			PreparedStatement st = cn.prepareStatement(sql);
			st.setString(1,roleid+"%");
			ResultSet rs = st.executeQuery();
			Integer count = 0;
			String currentStaffid = null;
			Integer currentRoleNumber = null, newRoleNumber = count + 1;
			while (rs.next()) {
				currentStaffid = rs.getString("员工号");
				currentRoleNumber = Integer.valueOf(currentStaffid.substring(1, currentStaffid.length()));
				if (currentRoleNumber > count + 1) {
					newRoleNumber = count + 1;
					break;
				}
				newRoleNumber = currentRoleNumber + 1;
				count = currentRoleNumber;
			}
			newStaffid = roleid + new DecimalFormat("000").format(newRoleNumber);
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			return null;
		}
		return newStaffid;
	}
	
	public static String getOrderid() {
		java.util.Date genTime = new java.util.Date( );
	    SimpleDateFormat sdf = new SimpleDateFormat ("yyyyMMddHHmmssS");
	    return sdf.format(genTime);
	}
	
	public static java.util.Date getDate(String datestr) {
		java.util.Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(datestr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}
	public static int setData(PreparedStatement st, String dataType, int idx, String value) {
		int status = 0;
		if (dataType == null) return status;
		try {
			if (dataType.equals("int")) {
				if (value == null) st.setNull(idx, java.sql.Types.INTEGER);
				else st.setInt(idx, Integer.valueOf(value));
			} else if (dataType.equals("bit")) {
				if (value == null) st.setNull(idx, java.sql.Types.BIT);
				else st.setInt(idx, Integer.valueOf(value));
			} else if (dataType.equals("enum")) {
				if (value == null) st.setNull(idx, java.sql.Types.CHAR);
				else st.setString(idx, value);
			} else if (dataType.equals("char")) {
				if (value == null) st.setNull(idx, java.sql.Types.CHAR);
				else st.setString(idx, value);
			} else if (dataType.equals("varchar")) {
				if (value == null) st.setNull(idx, java.sql.Types.VARCHAR);
				else st.setString(idx, value);
			} else if (dataType.equals("date")) {
				if (value == null) st.setNull(idx, java.sql.Types.DATE);
				else st.setDate(idx, new java.sql.Date(getDate(value).getTime()));
			}
			status = 1;
		} catch (SQLException e) {
			// pass
		}
		return status;
	}
	
	public static int insertRow(ServletContext sc, String table, ArrayList<String> fullValues) {
		int status = 0;
		try {
			Connection cn = getConnection(sc);
			String[] dataTypes = getDataTypes(cn, table);
			StringBuilder dynamicSql = new StringBuilder();
			dynamicSql.append("INSERT INTO ").append(table).append(" VALUES(");
			int colNum = dataTypes.length;
			for (int i = 0; i < colNum; i++) {
				if(i < colNum - 1) dynamicSql.append("?,");
				else dynamicSql.append("?);");
			}
			PreparedStatement st = cn.prepareStatement(dynamicSql.toString());
			for (int i = 0; i < colNum; i++) {
				setData(st, dataTypes[i], i+1, fullValues.get(i));
			}
			status = st.executeUpdate();
			st.close();
			cn.close();
		} catch (SQLException e) {
			// pass
		}
		return status;
	}
	
	/**
	 * Update
	 * @param sc
	 * @param primaryKey
	 * @param keyValue
	 * @param values
	 * @return
	 */
	
	public static int updateSingleValue(ServletContext sc, String table, String primaryKey, String keyValue, String field, String value) {
		int status = 0;
		try {
			String sql = "UPDATE " + table + " SET " + field + " = " + " ? WHERE " + primaryKey + " = " + keyValue + "; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			String[] fields = getFields(sc, table);
			String[] dataTypes = getDataTypes(cn, table);
			String dataType = null;
			for (int i = 0; i < fields.length; i++) {
				if (fields[i].equals(field)) {
					dataType = dataTypes[i];
					break;
				}
			}
			setData(st, dataType, 1, value);
			status = st.executeUpdate();
			st.close();
			cn.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return status;
	}
	
	public static int updateRow(ServletContext sc, String table, String primaryKey, String keyValue, ArrayList<String[]> fieldValues) {
		int status = 0;
		try {
			Connection cn = getConnection(sc);
			for (String[] fieldValue : fieldValues) {
				status = updateSingleValue(sc, table, primaryKey, keyValue, fieldValue[0], fieldValue[1]);
			}
			cn.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return status;
	}
	
	public static int[] getRoomNums(ServletContext sc) {
			Connection cn = getConnection(sc);
			String[] sqls = {"SELECT 房号  FROM 客房  WHERE 空置 = 1; ", "SELECT 房号 FROM 客房  WHERE 空置  = 0; "};
			return getNums(cn, sqls);
	}
	
	public static int[] getSpecificOrderNums(ServletContext sc) {
		Connection cn = getConnection(sc);
		String[] sqls = {"SELECT 订单号 FROM 预定中订单;", "SELECT 订单号 FROM 交易中订单;", "SELECT 订单号 FROM 已完成订单;" };
		return getNums(cn, sqls);
	}
	
	public static int[] getClientNums(ServletContext sc) {
		Connection cn = getConnection(sc);
		String[] sqls = {"SELECT 身份证号  FROM 用户 ;", "SELECT 员工号  FROM 员工;"};
		return getNums(cn, sqls);
	}
	
	public static int[] getNums(Connection cn, String[] sqls) {
		int[] nums = new int[sqls.length];
		try {
			PreparedStatement st = null;
			ResultSet rs = null;
			int count = 0;
			for (int i = 0; i < sqls.length; i++) {
				count = 0;
				st = cn.prepareStatement(sqls[i]);
				rs = st.executeQuery();
				while (rs.next()) count++;
				nums[i] = count;
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return nums; 
	}
	/**
	 * 
	 * @param sc
	 * @param accountType
	 * @param name
	 * @param passwd
	 * @return -1(ID已被注册), 0(注册失败), 1(注册成功)
	 */
	public static int permitSignUp(ServletContext sc, String accountType, String id, String name, String phone, String passwd) {
		int status = 1;
		switch (accountType) {
		case "private":
			String[] idcards = getSingleFieldValue(sc, "用户", "身份证号", "身份证号", id);
			if (idcards.length <= 0) {
				ArrayList<String> values = new ArrayList<String>();
				values.add(id);
				values.add(passwd);
				values.add(name);
				values.add(null);
				values.add(null);
				values.add(phone);
				if (insertRow(sc, "用户", values) <= 0) status = 0;
			} else status = -1;
			break;
		case "company":
			String[] staffids = getSingleFieldValue(sc, "员工", "员工号", "员工号", id);
			if (staffids.length > 0) {
				if (updateSingleValue(sc, "员工", "员工号", id, "密码", passwd) <= 0 ||
						updateSingleValue(sc, "员工", "员工号", id, "联系方式", phone) <= 0) status = 0;
			} else status = -1;
			break;
		default:
			break;
		}
		return status;
	}
	
	/**
	 * 
	 * @param sc
	 * @param accountType
	 * @param name
	 * @param passwd
	 * @return -1(密码错误), 0(账号不存在), 1(用户登陆), 2(经理登陆), 3(前台登陆)
	 */
	public static int permitSignIn(ServletContext sc, String accountType, String id, String passwd, String[] name, String[] phone) {
		int status = 0;
		switch (accountType) {
		case "private":
			String[] userPasswds = getSingleFieldValue(sc, "用户", "密码", "身份证号", id);
			if (userPasswds.length <= 0) status = 0;
			else {
				if (!userPasswds[0].equals(passwd)) status = -1;
				else {
					status = 1;
					name[0] = getSingleFieldValue(sc, "用户", "姓名", "身份证号", id)[0];
					phone[0] = getSingleFieldValue(sc, "用户", "联系方式", "身份证号", id)[0];
				}
			}
			break;
		case "company":
			String[] staffPasswds = getSingleFieldValue(sc, "员工", "密码", "员工号", id);
			if (staffPasswds.length <= 0) status = 0;
			else {
				if (!staffPasswds[0].equals(passwd)) status = -1;
				else {
					if (id.startsWith("0")) status = 2;
					if (id.startsWith("1")) status = 3;
					name[0] = getSingleFieldValue(sc, "员工", "姓名", "员工号", id)[0];
					phone[0] = getSingleFieldValue(sc, "员工", "联系方式", "员工号", id)[0];
				}
			}
			break;
		default:
			break;
		}
		return status;
	}
	
	public static ArrayList<RoomBean> getAvailableRooms(ServletContext sc) {
		ArrayList<RoomBean> availableRooms = new ArrayList<RoomBean>();
		try {
			String sql = "SELECT DISTINCT O.订单状态, O.入住日期, O.离店日期, M.空置, M.房号, " + 
					"M.类型, T.描述 AS 类型描述, M.描述 AS 客房描述, M.朝向, T.容量, T.价格 " + 
					"FROM 客房 AS M " + 
					"JOIN 客房类型 AS T ON M.类型 = T.类型 " + 
					"JOIN 客房_订单 AS R ON M.房号 = R.房号 " + 
					"LEFT JOIN 订单 AS O ON R.订单号 = O.订单号 " + 
					"WHERE M.空置 = 1 " + 
					"GROUP BY M.房号 HAVING COUNT(M.房号) >= 1;";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				RoomBean room = new RoomBean();
				room.setRoomId(rs.getString("房号"));
				room.setRoomType(rs.getString("类型"));
				room.setTypeDesc(rs.getString("类型描述"));
				room.setRoomDesc(rs.getString("客房描述"));
				room.setOrientation(rs.getString("朝向"));
				room.setCapacity(rs.getInt("容量"));
				room.setPrice(rs.getInt("价格"));
				availableRooms.add(room);
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return availableRooms;
	}
	
	public static ArrayList<RoomBean> searchRoom(ServletContext sc, String checkinDate, String checkoutDate, String roomType) {
		ArrayList<RoomBean> searchedRooms = new ArrayList<RoomBean>();
		try {
			String sql = "SELECT DISTINCT O.订单状态, O.入住日期, O.离店日期, M.空置, M.房号, " + 
					"M.类型, T.描述 AS 类型描述, M.描述 AS 客房描述, M.朝向, T.容量, T.价格 " + 
					"FROM 客房 AS M " + 
					"JOIN 客房类型 AS T ON M.类型 = T.类型 " + 
					"JOIN 客房_订单 AS R ON M.房号 = R.房号 " + 
					"LEFT JOIN 订单 AS O ON R.订单号 = O.订单号 " + 
					"WHERE NOT (M.类型 != ?  OR M.空置 = 0 " + 
					"OR (O.订单状态 = '交易中' AND (O.入住日期 >= ? OR O.离店日期 < ?))) " + 
					"GROUP BY M.房号 HAVING COUNT(M.房号) >= 1; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			setData(st, "varchar", 1, roomType);
			setData(st, "date", 2, checkoutDate);
			setData(st, "date", 3, checkinDate);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				RoomBean room = new RoomBean();
				room.setRoomId(rs.getString("房号"));
				room.setRoomType(rs.getString("类型"));
				room.setTypeDesc(rs.getString("类型描述"));
				room.setRoomDesc(rs.getString("客房描述"));
				room.setOrientation(rs.getString("朝向"));
				room.setCapacity(rs.getInt("容量"));
				room.setPrice(rs.getInt("价格"));
				searchedRooms.add(room);
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return searchedRooms;
	}
	
	public static String bookRoom(ServletContext sc, String roomType) {
		String roomId = null;
		try {
			String sql = "SELECT 房号 FROM 客房  AS A NATURAL JOIN 客房类型  AS B ON A.类型  = B.类型; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				int newSurplus = rs.getInt(1) - 1;
				if (updateSingleValue(sc, "客房类型", "类型", roomType, "价格", String.valueOf(newSurplus)) > 0) {
					roomId = rs.getString("房号");
				}
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return roomId;
	}
	
	public static String generateOrder(ServletContext sc, String[] checkDate, RoomBean room, ArrayList<ClientBean> lodgers) {
		String orderid = getOrderid();
		ArrayList<String> fullValues = new ArrayList<String>();
		fullValues.add(orderid);
		int lodgersNum = lodgers.size();
		fullValues.add(String.valueOf(lodgersNum));
		fullValues.add(checkDate[0]);
		fullValues.add(checkDate[1]);
		int price = room.getPrice();
		int days = (int)((getDate(checkDate[1]).getTime() - getDate(checkDate[0]).getTime())/(1000*3600*24)+0.5);
		int totalPrice = price * days;
		fullValues.add(String.valueOf(totalPrice));
		fullValues.add(lodgers.get(0).getPhone());
		fullValues.add(null);
		fullValues.add(null);
		fullValues.add("预定中");
		insertRow(sc, "订单", fullValues);

		for (ClientBean lodger : lodgers) {
			String[] idcards = getSingleFieldValue(sc, "住客", "身份证号", "身份证号", lodger.getId());
			if (idcards.length <= 0) {
				ArrayList<String> values = new ArrayList<String>();
				values.add(lodger.getId());
				values.add(lodger.getName());
				values.add(lodger.getGender());
				values.add(String.valueOf(lodger.getAge()));
				values.add(lodger.getPhone());
				insertRow(sc, "住客", values);
			}
			ArrayList<String> values = new ArrayList<String>();
			values.add(null);
			values.add(lodger.getId());
			values.add(orderid);
			insertRow(sc, "住客_订单", values);
		}
		
		updateSingleValue(sc, "客房", "房号", room.getRoomId(), "空置", "0");
		ArrayList<String> values = new ArrayList<String>();
		values.add(null);
		values.add(room.getRoomId());
		values.add(orderid);
		insertRow(sc, "客房_订单", values);
		
		int surplus = Integer.valueOf(getSingleFieldValue(sc, "客房类型", "余量", "类型", room.getRoomType())[0]);
		updateSingleValue(sc, "客房类型", "类型", room.getRoomType(), "余量", String.valueOf(--surplus));
		
		values = new ArrayList<String>();
		values.add(orderid);
		insertRow(sc, "预定中订单", values);
		
		return orderid;
	}
	
	public static String[][] getAdvanceOrder(ServletContext sc, String idcard) {
		String[][] result = null;
		try {
			String sql = "SELECT R.订单号, R.身份证号, O.入住日期, O.离店日期, O.入住人数, O.价格, O.订单状态  " + 
					"FROM  住客_订单 as R JOIN 订单 AS O ON R.订单号 = O.订单号 " + 
					"WHERE R.身份证号 = ? and O.订单状态 = '预定中'; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			setData(st, "char", 1, idcard);
			ResultSet rs = st.executeQuery();
			int rowNum = 0;
			while (rs.next()) rowNum++;
			int colNum = rs.getMetaData().getColumnCount();
			result = new String[rowNum+1][colNum];
			result[0] = new String[]{"订单号", "身份证号", "入住日期", "离店日期", "入住人数", "价格", "订单状态" };
			for (int row = 1; row <= rowNum; row++) {
				rs.absolute(row);
				for(int col = 0; col < colNum; col++) result[row][col] = rs.getString(col+1);
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			
		}
		return result;
	}
}