const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const braintree = require("braintree");

const gateway = new braintree.BraintreeGateway({
    environment: braintree.Environment.Sandbox,
    merchantId:'cwwspnfcwpjj263m',
    publicKey:'jj8zsgc8x7f62d8z',
    privateKey:'9d71c0d88a3546255a5db59bb73c770d'
});

exports.paypalPayment = functions.https.onRequest(async (req, res) => {
    const nonceFromTheClient = req.body.payment_method_nonce;
    const deviceData = req.body.device_data;

    gateway.transaction.sale({
        paymentMethodNonce: 'fake-paypal-one-time-nonce',
        deviceData: deviceData,
        options: {
            submitForSettlement: true
        }
    }, (err, result) => {
        if (err != null){
            console.log(err);
        }
        else {
            res.json({
                result: 'success'
            });
        }
    });
});