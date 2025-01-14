import ballerina/log;
import ballerinax/nats;

// Initializes a NATS listener.
listener nats:Listener subscription = new (nats:DEFAULT_URL);

// Binds the consumer to listen to the messages published to the 'demo.bbe' subject.
service "demo.bbe" on subscription {
    remote function onMessage(nats:Message message) returns error? {
        // Logs the incoming message.
        string messageContent = check string:fromBytes(message.content);
        log:printInfo("Received message: " + messageContent);
    }
}
