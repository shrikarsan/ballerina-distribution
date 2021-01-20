// This is the client implementation of the secured connection (HTTPS) scenario.
import ballerina/config;
import ballerina/grpc;
import ballerina/io;

public function main (string... args) returns error? {
    // Client endpoint configuration with SSL configurations.
    HelloWorldClient ep = check
        new ("https://localhost:9090", {
            secureSocket: {
                trustStore: {
                    path: config:getAsString("b7a.home") +
                            "/bre/security/ballerinaTruststore.p12",
                    password: "ballerina"
                }
            }
    });
    ContextString requestMessage = {content: "WSO2", headers: {}};
    // Executing unary call
    ContextString result = check ep->helloContext(requestMessage);
    // Print the content
    io:println(result.content);
}

public client class HelloWorldClient {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public isolated function init(string url, grpc:ClientConfiguration? config = ()) returns grpc:Error? {
        // Initialize client endpoint.
        self.grpcClient = check new(url, config);
        grpc:Error? result = self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function hello(string|ContextString req) returns (string|grpc:Error) {

        map<string|string[]> headers = {};
        string message;
        if (req is ContextString) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("HelloWorld/hello", message, headers);
        [anydata, map<string|string[]>][result, _] = payload;
        return result.toString();
    }
    isolated remote function helloContext(string|ContextString req) returns (ContextString|grpc:Error) {

        map<string|string[]> headers = {};
        string message;
        if (req is ContextString) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("HelloWorld/hello", message, headers);
        [anydata, map<string|string[]>][result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

}

# Context record includes message payload and headers.
public type ContextString record {|
    string content;
    map<string|string[]> headers;
|};
