const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.handlePreapprovalNotification = functions.https.onRequest(async (req, res) => {
  try {
    const { merchant_id, order_id, payment_id, payhere_amount, payhere_currency, status_code, customer_token } = req.body;

    // Update Firestore with the received data
    const db = admin.firestore();
    const preapprovalRef = db.collection('preapprovals').doc(order_id);
    await preapprovalRef.set({
      merchant_id,
      payment_id,
      amount: parseFloat(payhere_amount),
      currency: payhere_currency,
      status_code,
      customer_token
    });

    res.status(200).send('Notification received and database updated.');
  } catch (error) {
    console.error('Error handling preapproval notification:', error);
    res.status(500).send('An error occurred while handling the preapproval notification.');
  }
});
