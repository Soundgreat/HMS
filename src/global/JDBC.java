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

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

public class JDBC {
	/**
	 * 	ENUMS
	 */
	private static final ArrayList<String> STAFF_ROLES = new ArrayList<String>(Arrays.asList("经理", "前台"));
	
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
	
	public static ArrayList<String> getRoomTypes(ServletContext sc) {
		ArrayList<String> roomTypes = new ArrayList<String>();
		Connection cn = JDBC.getConnection(sc);
		String sql = "SELECT 类型 FROM 客房类型;";
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
	public static boolean deleteRow(ServletContext sc, String table, String primaryKey, String keyValue) {
		boolean success = false;
		try {
			String sql = "DELETE FROM " + table + " WHERE " + primaryKey + " = " + keyValue + "; ";
			Connection cn= getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			success = st.execute();
			st.close();
			cn.close();
		} catch (SQLException e) {
			// pass
		}
		return success;
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
			String sql = "SELECT 员工号 FROM 员工 WHERE 员工号 LIKE ?; ";
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
	
	public static boolean insertRow(ServletContext sc, String table, ArrayList<String> values) {
		boolean success = false;
		try {
			String sql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = ? AND TABLE_SCHEMA = 'hms'; ";
			Connection cn = getConnection(sc);
			PreparedStatement st = cn.prepareStatement(sql);
			st.setString(1, table);
			ResultSet dataTypesRs = st.executeQuery();
			ArrayList<String> dataTypes = new ArrayList<String>();
			while (dataTypesRs.next()) dataTypes.add(dataTypesRs.getString(1));
			
			int colNum = dataTypes.size();
			StringBuilder dynamicSql = new StringBuilder();
			dynamicSql.append("INSERT INTO ").append(table).append(" VALUES(");
			for (int i = 0; i < colNum; i++) {
				if(i < colNum - 1) dynamicSql.append("?,");
				else dynamicSql.append("?);");
			}
			st = cn.prepareStatement(dynamicSql.toString());
			for (int i = 0; i < colNum; i++) {
				if (dataTypes.get(i).contains("int")) {
					if (values.get(i) == null) st.setNull(i+1, java.sql.Types.INTEGER);
					else st.setInt(i+1, Integer.valueOf(values.get(i)));
				} else if (dataTypes.get(i).contains("bit")) {
					if (values.get(i) == null) st.setNull(i+1, java.sql.Types.BIT);
					else st.setInt(i+1, Integer.valueOf(values.get(i)));
				} else if (dataTypes.get(i).contains("date")) {
					if (values.get(i) == null) st.setNull(i+1, java.sql.Types.DATE);
					else st.setString(i+1, values.get(i));
				} else if (dataTypes.get(i).contains("char")) {
					if (values.get(i) == null) st.setNull(i+1, java.sql.Types.CHAR);
					else st.setString(i+1, values.get(i));
				} else if (dataTypes.get(i).contains("varchar")) {
					if (values.get(i) == null) st.setNull(i+1, java.sql.Types.VARCHAR);
					else st.setString(i+1, values.get(i));
				}
			}
			success = st.execute();
			st.close();
			cn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	/**
	 * Update
	 * @param sc
	 * @param primaryKey
	 * @param keyValue
	 * @param values
	 * @return
	 */
	public static boolean updateRow(ServletContext sc, String primaryKey, String keyValue, String[] values) {
		return false;
	}
}
