<%-- 
    Document   : home.jsp
    Created on : Feb 10, 2026, 9:45:32 AM
    Author     : Lam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Disaster Relief Donation & Distribution System</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, Helvetica, sans-serif;
                background-color: #f0f0f0; /* light grey background */
                color: #333333; /* dark grey text */
            }

            header {
            background: linear-gradient(90deg, #1e3a5f, #27496d); /* gradient header */
            padding: 15px 40px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2); /* subtle shadow */
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #ffffff;
            letter-spacing: 1px;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 25px;
            padding: 0;
            margin: 0;
        }

        nav ul li {
            position: relative;
        }

        nav ul li a {
            color: #ffffff;
            text-decoration: none;
            padding: 8px 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        nav ul li a:hover {
            background-color: #ffffff;
            color: #1e3a5f;
            border-radius: 5px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .dropdown {
            display: none;
            position: absolute;
            background-color: #2c3e50;
            min-width: 180px;
            top: 35px;
            left: 0;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            animation: fadeIn 0.3s ease;
        }

        .dropdown li a {
            display: block;
            padding: 10px;
            color: #ffffff;
            transition: background 0.3s ease;
        }

        .dropdown li a:hover {
            background-color: #ffffff;
            color: #1e3a5f;
        }

        nav ul li:hover .dropdown {
            display: block;
        }
            main {
                padding: 40px 0;
            }

            .container {
                max-width: 900px;
                margin: auto;
                background-color: #ffffff; /* white container */
                padding: 40px;
                border-radius: 10px;
                text-align: center;
                color: #333333;
            }

            .container h1 {
                color: #1e3a5f; /* blue heading */
            }

            .container p {
                font-size: 18px;
                line-height: 1.6;
                color: #555555; /* medium grey text */
            }

            .links a {
                display: inline-block;
                margin: 10px;
                padding: 12px 25px;
                background-color: #1e3a5f; /* blue buttons */
                color: #ffffff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
            }

            .links a:hover {
                background-color: #d9d9d9; /* grey hover */
                color: #1e3a5f;
            }

            .review-section {
                background-color: #2c3e50; /* grey-blue section */
                padding: 50px;
                margin-top: 50px;
                text-align: center;
                color: #ffffff;
            }

            .review-section h2 {
                color: #ffffff;
            }

            .review-form input,
            .review-form textarea {
                width: 100%;
                padding: 12px;
                margin-top: 10px;
                border: none;
                border-radius: 5px;
                background-color: #f0f0f0; /* light grey fields */
                color: #333333;
            }

            .review-form button {
                margin-top: 15px;
                padding: 12px 20px;
                background-color: #1e3a5f; /* blue button */
                color: #ffffff;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }

            .review-form button:hover {
                background-color: #d9d9d9; /* grey hover */
                color: #1e3a5f;
            }

            .posted-reviews {
                max-width: 700px;
                margin: 30px auto;
                text-align: left;
            }

            .review {
                background-color: #f0f0f0; /* light grey review box */
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 12px;
                color: #333333;
            }

            .review strong {
                color: #1e3a5f; /* blue names */
            }

            footer {
                background-color: #1e3a5f; /* deep blue footer */
                text-align: center;
                padding: 15px;
                margin-top: 50px;
                color: #ffffff;
            }


        </style>
    </head>
    <body>
        <header>
            <nav>
                <div class="logo">Donation System</div>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li>
                        <a href="#">Register</a>
                        <ul class="dropdown">
                            <li><a href="addDisaster.jsp">Add Disasters</a></li>
                            <li><a href="registerDonation.jsp">Donor & Donation</a></li>
                            <li><a href="distribution.jsp">Distribute</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">View</a>
                        <ul class="dropdown">
                            <li><a href="viewDonations.jsp">View Donations</a></li>
                            <li><a href="viewDisasters.jsp">View Disasters</a></li>
                            <li><a href="viewDistribution.jsp">View Distribution</a></li>
                        </ul>
                    </li>
                    <li><a href="reports.jsp">Relief Reports</a></li>
                </ul>
            </nav>
        </header>


        <main>
            <!-- Intro Section -->
            <section class="container">
                <h1>Welcome to Disaster Relief Donation & Distribution System</h1>
                <p>
                    Our platform is designed to coordinate and manage relief donations effectively — whether it’s emergency funds, food supplies, clothing, or medical aid. 
                    By streamlining the process of collecting and distributing resources, we ensure that help reaches affected communities quickly, transparently, and with accountability. 
                    Together, we can make disaster response faster, fairer, and more impactful.
                </p>


                <div class="links">
                    <a href="addDisaster.jsp">Manage Disasters</a>
                    <a href="registerDonation.jsp">Register Donations</a>
                    <a href="distribution.jsp">Distribute Donation</a>
                </div>
            </section>




            <section class="review-section">
                <h2>Reviews</h2>

                <div class="review-form">
                    <input type="text" id="reviewerName" placeholder="Your Name">
                    <textarea id="reviewText" placeholder="Write your review..."></textarea>
                    <button onclick="postReview()">Submit</button>
                    <button onclick="dataRemove()">Remove All Reviews</button>
                </div>

                <div id="postedReviews" class="posted-reviews"></div>
            </section>

        </main>

        <footer>
            &copy; 2026 Disaster Relief Donation & Distribution System | Designed by Lam , Hafsa & Feona.
        </footer>
        <script>

            window.onload = function () {
                showReviews();
            };

            function postReview() {
                const name = document.getElementById("reviewerName").value.trim();
                const text = document.getElementById("reviewText").value.trim();

                if (name && text) {

                    let reviews = JSON.parse(localStorage.getItem("customers")) || [];


                    reviews.push({name: name, text: text});


                    localStorage.setItem("customers", JSON.stringify(reviews));


                    showReviews();


                    document.getElementById("reviewerName").value = "";
                    document.getElementById("reviewText").value = "";
                } else {
                    alert("Please fill both name and review fields.");
                }
            }

            function showReviews() {
                const container = document.getElementById("postedReviews");


                let reviews = JSON.parse(localStorage.getItem("customers")) || [];

                // If no reviews exist
                if (reviews.length === 0) {
                    container.innerHTML = "<p><i>No reviews yet. Be the first to write one!</i></p>";
                    return;
                }

                // Build review list dynamically
                container.innerHTML = reviews.map(r => `
        <div class="review">
            <strong>${r.name}:</strong> ${r.text}
        </div>
    `).join("");
            }


            function dataRemove() {
                localStorage.removeItem("customers");
                document.getElementById("postedReviews").innerHTML = "<p><i>All reviews cleared.</i></p>";
            }
        </script>

    </body>
</html>

