<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
    $phone = $_POST['phone'];
    $address = $_POST['address'];

    $stmt = $pdo->prepare("INSERT INTO customers (name, email, password, phone, address) VALUES (?, ?, ?, ?, ?)");
    $stmt->execute([$name, $email, $password, $phone, $address]);

    echo "Registration successful!";
}
?>

<form id="registerForm" action="register.php" method="POST">
  <input type="text" name="name" placeholder="Full Name" required>
  <input type="email" name="email" placeholder="Email" required>
  <input type="password" name="password" placeholder="Password" required>
  <input type="text" name="phone" placeholder="Phone Number">
  <textarea name="address" placeholder="Address"></textarea>
  <button type="submit">Register</button>
</form>

let cart = [];
function addToCart(itemId, quantity) {
  cart.push({ id: itemId, quantity: quantity });
  localStorage.setItem('cart', JSON.stringify(cart));
}
function getCart() {
  return JSON.parse(localStorage.getItem('cart')) || [];
}

SELECT c.address, r.delivery_zone 
FROM customers c 
JOIN restaurants r 
ON r.id = ? 
WHERE c.id = ? AND c.address LIKE r.delivery_zone;

<?php
try {
    $pdo->beginTransaction();

    $orderStmt = $pdo->prepare("INSERT INTO orders (customer_id, restaurant_id, total_amount, status) VALUES (?, ?, ?, ?)");
    $orderStmt->execute([$customerId, $restaurantId, $totalAmount, 'Pending']);
    $orderId = $pdo->lastInsertId();

    foreach ($orderItems as $item) {
        $itemStmt = $pdo->prepare("INSERT INTO order_items (order_id, menu_item_id, quantity) VALUES (?, ?, ?)");
        $itemStmt->execute([$orderId, $item['id'], $item['quantity']]);
    }

    $pdo->commit();
    echo "Order placed successfully!";
} catch (Exception $e) {
    $pdo->rollBack();
    echo "Failed to place order: " . $e->getMessage();
}
?>
