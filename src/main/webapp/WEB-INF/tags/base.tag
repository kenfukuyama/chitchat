<%@tag description="base layout" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- bootstrap css -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css"/>
    <!-- css -->
    <link rel="stylesheet" href="/css/style.css">
    <!-- bootstrap javascript -->
    <script defer src="/webjars/jquery/jquery.min.js"></script>
    <script defer src="/webjars/bootstrap/js/bootstrap.min.js"></script>

    <!-- javascript -->
    <script defer type="text/javascript" src="/js/script.js"></script>

    <!-- javascript for websocket library -->
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    
    <!-- anime.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js" integrity="sha512-z4OUqw38qNLpn1libAN9BsoDx6nbNFio5lA6CuTp9NlK83b89hgyCVq+N5FdBJptINztxn1Z3SaKSKUS5UP60Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
</head>
<body>
 <jsp:doBody/>
</body>
</html>