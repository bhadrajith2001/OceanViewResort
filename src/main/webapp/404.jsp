<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            overflow: hidden;
        }

        h1 {
            font-size: 120px;
            margin: 0;
            color: #2ca1bd;
            text-shadow: 0 0 30px rgba(44, 161, 189, 0.5);
            animation: float 3s ease-in-out infinite;
        }

        h2 { font-size: 30px; margin: 10px 0; font-weight: 300; }
        p { color: #aaa; font-size: 14px; letter-spacing: 1px; margin-bottom: 40px; }

        .btn {
            padding: 15px 40px;
            background: #2ca1bd;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn:hover { background: #1b7a91; transform: translateY(-3px); box-shadow: 0 8px 25px rgba(44, 161, 189, 0.4); }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }
    </style>
</head>
<body>

<h1>404</h1>
<h2>Oops! Lost at Sea?</h2>
<p>The page you are looking for does not exist or has been moved.</p>

<a href="index.html" class="btn">Return to Shore (Home)</a>

</body>
</html>