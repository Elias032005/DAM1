<?php
class Conexion {
    private $host = 'localhost';
    private $dbname = 'pruebaphp';
    private $username = 'root';
    private $password = '';
    private $puerto = '3306';
    private $conn;

    public function __construct() {
        $this->conn = null;
    }

    public function conectar() {
        try {
            $dsn = "mysql:host={$this->host};port={$this->puerto};dbname={$this->dbname}";
            $this->conn = new PDO($dsn, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            echo "Conexión exitosa a la base de datos.";
        } catch (PDOException $e) {
            echo "Error de conexión: " . $e->getMessage();
        }
        return $this->conn;
    }
}
?>
