<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stripe Checkout</title>
    
    <!-- Stripe.js -->
    <script src="https://js.stripe.com/v3/"></script>

    <!-- Button Styling -->
    <style>
        #checkout-button {
            background-color: #6772e5;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        #checkout-button:hover {
            background-color: #5469d4;
        }
    </style>
</head>

<body>
<button id="checkout-button">Checkout</button>

<script>
  const stripe = Stripe('pk_test_51QlQe5PO5PNshsgdtUMyjNn6KbZHlgMD4vlkvIHDvXNPwF5rFBASJtnoEWmwRNSCzwL8NsjCllTmNrrU1n5yzidf00PT3TeXJf'); // Replace with your Stripe publishable key

  document.getElementById('checkout-button').addEventListener('click', () => {
	  fetch('http://localhost:8080/J2EE_CA2_Spotless/public/create-checkout-session', {
	      method: 'POST',
	    })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        return stripe.redirectToCheckout({ sessionId: data.id });
      })
      .then(result => {
        if (result.error) {
          alert(result.error.message);
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('An error occurred during checkout. Please try again.');
      });
  });
</script>

</body>
</html>