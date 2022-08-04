package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class MemberManagerBean {
	Connection conn;
	PreparedStatement pstmt;
	final String sql_insert = "INSERT INTO MEMBER VALUES((SELECT NVL(MAX(MPK),0)+1 FROM MEMBER),?, ?)";
	final String sql_selectAll="SELECT * FROM MEMBER";
//	final String sql_selectAll = "SELECT * FROM MEMBER WHERE UPPER(NAME) LIKE UPPER('%'||?||'%')";

	final String sql_selectOne="SELECT * FROM MEMBER WHERE MPK = ?";
	final String sql_delete = "DELETE FROM MEMBER WHERE MPK = ?";
	final String sql_update = "UPDATE MEMBER SET NAME=?, SCORE=? WHERE MPK=?";


	
	public boolean insert(MemberBean mb) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_insert);
			pstmt.setString(1, mb.getName());
			pstmt.setInt(2, mb.getScore());
			int res = pstmt.executeUpdate();
			if(res <= 0) {
				System.out.println("   로그 : 추가 실패");
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public ArrayList<MemberBean> selectAll(MemberBean mb) {
		conn = JDBCUtil.connect();
		ArrayList<MemberBean> datas = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql_selectAll);
//			pstmt.setString(1, mb.getName());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean data = new MemberBean(); 
				data.setMpk(rs.getInt("mpk"));
				data.setName(rs.getString("name"));
				data.setScore(rs.getInt("score"));
				datas.add(data);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		 return datas;
		
		
	}
	public MemberBean selectOne(MemberBean mb) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_selectOne);
			pstmt.setInt(1, mb.getMpk());
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				MemberBean data = new MemberBean();
				data.setMpk(rs.getInt("mpk"));
				data.setName(rs.getString("name"));
				data.setScore(rs.getInt("score"));
				return data;
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return null;
	}
	public boolean delete(MemberBean mb) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_delete);
			pstmt.setInt(1, mb.getMpk());
			int res = pstmt.executeUpdate();
			if(res <= 0) {
				System.out.println("로그 : 삭제 실패");
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean update(MemberBean mb) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_update);
			pstmt.setString(1, mb.getName());
			pstmt.setInt(2, mb.getScore());
			pstmt.setInt(3, mb.getMpk());
			int res = pstmt.executeUpdate();
			if(res <= 0) {
				System.out.println("로그 : 변경 실패");
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
}
