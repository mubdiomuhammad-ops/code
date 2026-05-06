<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="Connection.jsp" %>
<%    String donationIdParam = request.getParameter("donation_id");
    String donorName = request.getParameter("donor_name");
    String donationType = request.getParameter("donation_type");
    String amountParam = request.getParameter("amount");
    String goodsDescription = request.getParameter("goods_description");
    String disasterIdParam = request.getParameter("disaster_id");

    int donationId = 0;
    Double amount = null;
    int donorId = 0;

    try {

        if (donationIdParam != null && donationIdParam.matches("\\d+")) {
            donationId = Integer.parseInt(donationIdParam);
        } else {
            out.println("Error: donation_id must be numeric.");
            return;
        }

        if (amountParam != null && !amountParam.isEmpty()) {
            if (amountParam.matches("\\d+(\\.\\d+)?")) {
                amount = Double.parseDouble(amountParam);
            } else {
                out.println("Error: amount must be numeric.");
                return;
            }
        }

        if (donorName != null && !donorName.isEmpty()) {
            // Insert new donor with auto-generated ID
            PreparedStatement psDonor = conn.prepareStatement(
                    "INSERT INTO DONORS(donor_id, donor_name) VALUES(donor_seq.NEXTVAL, ?)",
                    new String[]{"donor_id"} // return generated key
            );
            psDonor.setString(1, donorName);
            psDonor.executeUpdate();

            ResultSet rsKeys = psDonor.getGeneratedKeys();
            if (rsKeys.next()) {
                donorId = rsKeys.getInt(1);
            }
            rsKeys.close();
            psDonor.close();
        }

        PreparedStatement ps = conn.prepareStatement(
                "UPDATE DONATIONS SET donor_id=?, donation_type=?, amount=?, goods_description=? WHERE donation_id=?"
        );
        ps.setInt(1, donorId);
        ps.setString(2, donationType);

        if (amount != null) {
            ps.setDouble(3, amount);
        } else {
            ps.setNull(3, java.sql.Types.DOUBLE);
        }

        ps.setString(4, goodsDescription);
        ps.setInt(5, donationId);
        ps.executeUpdate();
        ps.close();

        PreparedStatement ps2 = conn.prepareStatement(
                "DELETE FROM DISTRIBUTION WHERE donation_id=?"
        );
        ps2.setInt(1, donationId);
        ps2.executeUpdate();
        ps2.close();

        if (disasterIdParam != null && disasterIdParam.matches("\\d+")) {
            int disasterId = Integer.parseInt(disasterIdParam);

            PreparedStatement psCheck = conn.prepareStatement(
                    "SELECT 1 FROM DISASTERS WHERE disaster_id=?"
            );
            psCheck.setInt(1, disasterId);
            ResultSet rs = psCheck.executeQuery();

            if (!rs.next()) {
                out.println("Error: disaster_id not found in DISASTERS.");
                return;
            }

            rs.close();
            psCheck.close();

            PreparedStatement ps3 = conn.prepareStatement(
                    "INSERT INTO DISTRIBUTION(distribution_id, donation_id, disaster_id, distribution_date) "
                    + "VALUES(distribution_seq.NEXTVAL, ?, ?, SYSDATE)"
            );
            ps3.setInt(1, donationId);
            ps3.setInt(2, disasterId);
            ps3.executeUpdate();
            ps3.close();
        }

        response.sendRedirect("viewDonations.jsp");

    } catch (NumberFormatException e) {
        out.println("Error: invalid number format.");
        return;
    }
%>
