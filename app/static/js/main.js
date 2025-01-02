document.getElementById('paymentForm').addEventListener('submit', async function (e) {
    e.preventDefault();

    const data = {
        first_name: document.getElementById('first_name').value,
        last_name: document.getElementById('last_name').value,
        email: document.getElementById('email').value,
        amount: parseInt(document.getElementById('amount').value, 10),
        user_id: document.getElementById('user_id').value
    };

    try {
        const response = await fetch('/create-transaction', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });

        if (!response.ok) {
            const errorDetails = await response.json();
            console.error('Error:', errorDetails);
            alert(`Failed to create transaction: ${errorDetails.error}`);
            return;
        }

        const result = await response.json();
        if (result.redirect_url) {
            window.location.href = result.redirect_url;
        } else {
            alert('Failed to get redirect URL!');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('An error occurred. Please try again.');
    }
});
