document.getElementById('contactForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent form submission

    // Get form values
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const message = document.getElementById('message').value;

    // Simple validation
    if (name === '' || email === '' || message === '') {
        alert('Please fill in all fields');
        return;
    }

    // Simulate form submission
    document.getElementById('responseMessage').textContent = 'Thank you, ' + name + '! Your message has been received.';

    // Clear form fields
    document.getElementById('contactForm').reset();
});
