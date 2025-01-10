<?php
session_start();

if (isset($_POST['login'])) {
    $host = 'localhost';
    $dbname = 'pruebaphp';
    $username = 'root';
    $password = '';
    $puerto = '3306';

    try {
        // Crear la conexión PDO para MySQL
        $conn = new PDO("mysql:host=$host;port=$puerto;dbname=$dbname", $username, $password);
        // Establecer el modo de error
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Obtener los datos del formulario
        $user = $_POST['username'];
        $pass = $_POST['password'];

        // Preparar la consulta para evitar inyecciones SQL
        $stmt = $conn->prepare("SELECT * FROM usuarios WHERE nombre_usuario = :username");
        $stmt->bindParam(':username', $user);
        $stmt->execute();

        // Verificar si el usuario existe
        if ($stmt->rowCount() > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            // Verificar la contraseña
            if (password_verify($pass, $row['contrasena'])) {
                // Contraseña correcta, iniciar sesión
                $_SESSION['user_id'] = $row['id_usuario'];
                $_SESSION['username'] = $row['nombre_usuario'];
                echo "Bienvenido, " . $row['nombre_usuario'] . "!";
                // Redirigir a la página de inicio o dashboard
                // header("Location: dashboard.php");
                // exit();
            } else {
                echo "Contraseña incorrecta.";
            }
        } else {
            echo "Usuario no encontrado.";
        }
    } catch (PDOException $exp) {
        echo "Error de conexión: " . $exp->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" src="style.css">
    <title>Iniciar sesión</title>
</head>
<body>
    <h2>Iniciar sesión</h2>
    <form method="post" action="index.php">
        <label for="username">Nombre de usuario:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit" name="login">Iniciar sesión</button>
    </form>
</body>
</html>
