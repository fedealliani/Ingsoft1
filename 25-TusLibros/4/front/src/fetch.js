const getLocalAsJson = (path) => {

	return fetch(`http://localhost:${WS_PORT}/${path}`, {
		method: "GET",
		dataType: "JSON",
		headers: {
			"Access-Control-Request-Headers": "*"
		}
	})
}
