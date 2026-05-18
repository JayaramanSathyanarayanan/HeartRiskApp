package com.heartrisk.dao;
import com.heartrisk.model.Assessment;
import com.heartrisk.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class AssessmentDAO {

    public int save(Assessment paramAssessment) {
        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement preparedStatement = connection.prepareStatement(
                        "INSERT INTO assessments (user_id, age, gender, height_cm, weight_kg, bmi, systolic_bp, diastolic_bp, cholesterol, glucose, smoking, alcohol, active, risk_score, risk_level) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        1
                );

                try {
                    preparedStatement.setInt(1, paramAssessment.getUserId());
                    preparedStatement.setInt(2, paramAssessment.getAge());
                    preparedStatement.setInt(3, paramAssessment.getGender());
                    preparedStatement.setDouble(4, paramAssessment.getHeightCm());
                    preparedStatement.setDouble(5, paramAssessment.getWeightKg());
                    preparedStatement.setDouble(6, paramAssessment.getBmi());
                    preparedStatement.setInt(7, paramAssessment.getSystolicBp());
                    preparedStatement.setInt(8, paramAssessment.getDiastolicBp());
                    preparedStatement.setInt(9, paramAssessment.getCholesterol());
                    preparedStatement.setInt(10, paramAssessment.getGlucose());
                    preparedStatement.setInt(11, paramAssessment.getSmoking());
                    preparedStatement.setInt(12, paramAssessment.getAlcohol());
                    preparedStatement.setInt(13, paramAssessment.getActive());
                    preparedStatement.setDouble(14, paramAssessment.getRiskScore());
                    preparedStatement.setString(15, paramAssessment.getRiskLevel());

                    if (preparedStatement.executeUpdate() == 1) {
                        ResultSet resultSet = preparedStatement.getGeneratedKeys();
                        try {
                            if (resultSet.next()) {
                                int id = resultSet.getInt(1);
                                resultSet.close();
                                preparedStatement.close();
                                connection.close();
                                return id;
                            }
                        } finally {
                            resultSet.close();
                        }
                    }

                    preparedStatement.close();
                } finally {
                    connection.close();
                }
            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Assessment> findByUser(int userId) {
        List<Assessment> list = new ArrayList<>();

        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement preparedStatement = connection.prepareStatement(
                        "SELECT * FROM assessments WHERE user_id = ? ORDER BY assessed_at DESC"
                );

                preparedStatement.setInt(1, userId);
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    list.add(map(resultSet));
                }

                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public Assessment findLatest(int userId) {
        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement preparedStatement = connection.prepareStatement(
                        "SELECT * FROM assessments WHERE user_id = ? ORDER BY assessed_at DESC LIMIT 1"
                );

                preparedStatement.setInt(1, userId);
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    Assessment assessment = map(resultSet);
                    resultSet.close();
                    preparedStatement.close();
                    connection.close();
                    return assessment;
                }

                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int countByUser(int userId) {
        try {
            Connection connection = DBConnection.getConnection();
            try {
                PreparedStatement preparedStatement = connection.prepareStatement(
                        "SELECT COUNT(*) FROM assessments WHERE user_id = ?"
                );

                preparedStatement.setInt(1, userId);
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    resultSet.close();
                    preparedStatement.close();
                    connection.close();
                    return count;
                }

                resultSet.close();
                preparedStatement.close();
                connection.close();
            } catch (Throwable t) {
                throw t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    private Assessment map(ResultSet rs) throws SQLException {
        Assessment assessment = new Assessment();
        assessment.setId(rs.getInt("id"));
        assessment.setUserId(rs.getInt("user_id"));
        assessment.setAge(rs.getInt("age"));
        assessment.setGender(rs.getInt("gender"));
        assessment.setHeightCm(rs.getDouble("height_cm"));
        assessment.setWeightKg(rs.getDouble("weight_kg"));
        assessment.setBmi(rs.getDouble("bmi"));
        assessment.setSystolicBp(rs.getInt("systolic_bp"));
        assessment.setDiastolicBp(rs.getInt("diastolic_bp"));
        assessment.setCholesterol(rs.getInt("cholesterol"));
        assessment.setGlucose(rs.getInt("glucose"));
        assessment.setSmoking(rs.getInt("smoking"));
        assessment.setAlcohol(rs.getInt("alcohol"));
        assessment.setActive(rs.getInt("active"));
        assessment.setRiskScore(rs.getDouble("risk_score"));
        assessment.setRiskLevel(rs.getString("risk_level"));
        assessment.setAssessedAt(rs.getTimestamp("assessed_at"));
        return assessment;
    }
}
