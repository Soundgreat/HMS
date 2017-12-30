package global;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

public class JDBC {
	/**
	 * 	ENUMS
	 */
	private static final ArrayList<String> STAFF_ROLES = new ArrayList<String>(Arrays.asList("����", "ǰ̨"));
	
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
				if (!rs.getString(1).equals("ס��_����")) tables.add(rs.getString(1));	
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
		String sql = "SELECT ���� FROM �ͷ�����;";
		try {
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				roomTypes.add(rs.getString("����"));
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
			String referencedTable = "����";
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
			String sql = "SELECT Ա���� FROM Ա�� WHERE Ա���� LIKE ?; ";
			PreparedStatement st = cn.prepareStatement(sql);
			st.setString(1,roleid+"%");
			ResultSet rs = st.executeQuery();
			Integer count = 0;
			String currentStaffid = null;
			Integer currentRoleNumber = null, newRoleNumber = count + 1;
			while (rs.next()) {
				currentStaffid = rs.getString("Ա����");
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
		Date genTime = new Date( );
	      SimpleDateFormat sdf = new SimpleDateFormat ("yyyyMMddhhmmssS");
	      return sdf.format(genTime);
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
			} else if (dataType.equals("date")) {
				if (value == null) st.setNull(idx, java.sql.Types.DATE);
				else {
					long date = Long.valueOf(value);
					st.setDate(idx, new java.sql.Date(date));
				}
			} else if (dataType.equals("char")) {
				if (value == null) st.setNull(idx, java.sql.Types.CHAR);
				else st.setString(idx, value);
			} else if (dataType.equals("varchar")) {
				if (value == null) st.setNull(idx, java.sql.Types.VARCHAR);
				else st.setString(idx, value);
			}
			status = 1;
		} catch (SQLException e) {
			// TODO: handle exception
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
			int colNum = fullValues.size();
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
	
	private static int updateSingleValue(ServletContext sc, String table, String primaryKey, String keyValue, String field, String value) {
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
			String[] sqls = {"SELECT ����  FROM �ͷ�  WHERE ���� = 1; ", "SELECT ���� FROM �ͷ� WHERE ����  = 0; "};
			return getNums(cn, sqls);
	}
	
	public static int[] getSpecificOrderNums(ServletContext sc) {
		Connection cn = getConnection(sc);
		String[] sqls = {"SELECT ������ FROM Ԥ���ж���;", "SELECT ������ FROM �����ж���;", "SELECT ������ FROM ����ɶ���;" };
		return getNums(cn, sqls);
	}
	
	public static int[] getClientNums(ServletContext sc) {
		Connection cn = getConnection(sc);
		String[] sqls = {"SELECT ���֤�� FROM �û� ;", "SELECT ���֤�� FROM ס��;"};
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
	 * @return
	 */
	public static int permitSignUp(ServletContext sc, String accountType, String name, String passwd) {
		int status = 1;
		switch (accountType) {
		case "user":
			String[] idcards = getSingleFieldValue(sc, "�û�", "���֤��", "���֤��", name);
			if (idcards.length <= 0) {
				ArrayList<String> values = new ArrayList<String>();
				values.add(name);
				values.add(passwd);
				if (insertRow(sc, "�û�", values) <= 0) status = -1;
			} else status = 0;
			break;
		case "staff":
			String[] staffids = getSingleFieldValue(sc, "�û�", "Ա����", "Ա����", name);
			if (staffids.length > 0) {
				if (updateSingleValue(sc, "Ա��", "Ա����", name, "����", passwd) <= 0) status = -1;
			} else status = 0;
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
	 * @return -1(�������), 0(���ƴ���), 1(�û���½�ɹ�), 2(�����½�ɹ�), 3(ǰ̨��½�ɹ�)
	 */
	public static int permitSignIn(ServletContext sc, String accountType, String name, String passwd, String[] showingName) {
		int status = 0;
		switch (accountType) {
		case "private":
			String[] userPasswds = getSingleFieldValue(sc, "�û�", "����", "���֤��", name);
			if (userPasswds.length <=0) status = 0;
			else {
				if (!userPasswds[0].equals(passwd)) status = -1;
				else {
					status = 1;
					showingName[0] = getSingleFieldValue(sc, "�û�", "����", "���֤��", name)[0];
				}
			}
			break;
		case "company":
			String[] staffPasswds = getSingleFieldValue(sc, "Ա��", "����", "Ա����", name);
			if (staffPasswds.length <= 0) status = 0;
			else {
				if (!staffPasswds[0].equals(passwd)) status = -1;
				else {
					if (name.startsWith("0")) status = 2;
					if (name.startsWith("1")) status = 3;
					showingName[0] = getSingleFieldValue(sc, "Ա��", "����", "Ա����", name)[0];
				}
			}
			break;
		default:
			break;
		}
		return status;
	}
	
	public static HashMap<String, Integer> searchRoom(ServletContext sc, String roomType) {
		HashMap<String, Integer> roomTypeInfo = new HashMap<String, Integer>();
		try {
			String sql = "SELECT ����,���� FROM �ͷ�����; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				if (rs.getInt(2) > 0) roomTypeInfo.put(rs.getString(1), rs.getInt(2));
			}
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return roomTypeInfo;
	}
	
	public static int bookRoom(ServletContext sc, String roomType) {
		int status = 0;
		try {
			String sql = "SELECT ���� FROM �ͷ�����; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			int newSurplus = rs.getInt(1) - 1;
			status = updateSingleValue(sc, "�ͷ�����", "����", roomType, "����", String.valueOf(newSurplus));
			rs.close();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	
	public static int generateOrder(ServletContext sc, String roomType, String checkinDate, String checkoutDate, String phoneNum, HashMap<String, HashMap<String, String>> lodgers) {
		int status = 0;
		String orderid = getOrderid();
		ArrayList<String> fullValues = new ArrayList<String>();
		fullValues.add(orderid);
		int lodgersNum = lodgers.size();
		fullValues.add(String.valueOf(lodgersNum));
		fullValues.add(checkinDate);
		fullValues.add(checkoutDate);
		int price = Integer.valueOf(getSingleFieldValue(sc, "�ͷ�����", "�۸�", "�ͷ�����", roomType)[0]);
		int days = (int)((new Date(Long.valueOf(checkoutDate)).getTime() - new Date(Long.valueOf(checkinDate)).getTime())/(1000*3600*24)+0.5);
		int totalPrice = price * days;
		fullValues.add(String.valueOf(totalPrice));
		fullValues.add(phoneNum);
		fullValues.add(null);
		fullValues.add(null);
		fullValues.add("Ԥ����");
		status = insertRow(sc, "����", fullValues);
		return status;
	}
}