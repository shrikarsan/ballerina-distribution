# 100 continue

Convenience functions are provided in the HTTP library for ease of use when handling `100-continue` scenarios.  `100-continue` indicates that the server has received the request headers and the client can proceed with sending the request.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_100_continue.bal :::

Run the service as follows.

::: out http_100_continue.server.out :::

Invoke the service by executing the following cURL commands in a new terminal.

::: out http_100_continue.client.out :::

