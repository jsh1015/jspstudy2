package model;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBConnection {
	private static SqlSessionFactory sqlMap;
	//static���� ��� ��ü�� �Ѱ��� ���
	static {
		String resource = "model/mapper/mybatis-config.xml";
		//model.mapper�� �ƴ� model/mapper : �����̱⶧��
		//mybatis-config.xml ������ ��ġ
		
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		//build : Connection ��ü ����.
		//			SQL ���� �����ϴ� �����̳� ����(reader�κ��� �о��)
		sqlMap = new SqlSessionFactoryBuilder().build(reader);
	}
	static SqlSession getConnection() {
		return sqlMap.openSession();//db�� �����ϱ�
		//sqlMap���ִ� connection��ü�� �̿��ؼ�
	}
	//�ܺο����� ������ �� ���� ������Ű�������� ���
	static void close(SqlSession session) {
		session.commit();
		session.close();
	}
}