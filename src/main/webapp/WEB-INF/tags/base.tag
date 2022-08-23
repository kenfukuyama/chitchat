<%@tag description="base layout" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>

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
    
    <link rel="icon" type="image/x-icon" href=/assets/images/favicon/chitchat.png>
        
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
    
    <!-- Live Search -->
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script defer src="/js/searchBar.js"></script>
    
    <!-- Tabs -->
    <script defer type="text/javascript" src="/js/tabs.js"></script>
</head>
<body>
<!-- Navbar -->
    <nav class="navbar navbar-expand-sm fixed-top">
      <div class="container-fluid ps-2 pe-3 styled-text">
        <a href="/" class="navbar-brand text-white">
        <svg width="210" height="40" viewBox="0 0 272 47" fill="none" xmlns="http://www.w3.org/2000/svg" class="pt-2">
			<g filter="url(#filter0_d_2_41)">
				<path d="M7.936 34.096C5.632 31.0667 4.48 26.1813 4.48 19.44C4.48 12.6987 5.632 7.81332 7.936 4.78399C10.24 1.75466 14.0587 0.23999 19.392 0.23999C24.7253 0.23999 28.5653 1.71199 30.912 4.65599L29.504 5.93599C27.6267 3.41866 24.256 2.15999 19.392 2.15999C17.2587 2.15999 15.4667 2.39466 14.016 2.86399C12.5653 3.29066 11.2213 4.12266 9.984 5.35999C8.78933 6.55466 7.89333 8.32532 7.296 10.672C6.69866 12.976 6.4 15.8987 6.4 19.44C6.4 22.9813 6.69866 25.9253 7.296 28.272C7.89333 30.576 8.78933 32.3467 9.984 33.584C11.2213 34.7787 12.5653 35.6107 14.016 36.08C15.4667 36.5067 17.2587 36.72 19.392 36.72C24.256 36.72 27.6267 35.4613 29.504 32.944L30.912 34.224C28.5653 37.168 24.7253 38.64 19.392 38.64C14.0587 38.64 10.24 37.1253 7.936 34.096Z" fill="white"/>
				<path d="M63.495 38H61.575V19.44H42.375V38H40.455V0.87999H42.375V17.52H61.575V0.87999H63.495V38Z" fill="white"/>
				<path d="M75.6425 0.87999H77.5625V38H75.6425V0.87999Z" fill="white"/>
				<path d="M113.705 0.87999V2.79999H100.265V38H98.345V2.79999H84.905V0.87999H113.705Z" fill="white"/>
				<path d="M141.811 34.096C139.507 31.0667 138.355 26.1813 138.355 19.44C138.355 12.6987 139.507 7.81332 141.811 4.78399C144.115 1.75466 147.934 0.23999 153.267 0.23999C158.6 0.23999 162.44 1.71199 164.787 4.65599L163.379 5.93599C161.502 3.41866 158.131 2.15999 153.267 2.15999C151.134 2.15999 149.342 2.39466 147.891 2.86399C146.44 3.29066 145.096 4.12266 143.859 5.35999C142.664 6.55466 141.768 8.32532 141.171 10.672C140.574 12.976 140.275 15.8987 140.275 19.44C140.275 22.9813 140.574 25.9253 141.171 28.272C141.768 30.576 142.664 32.3467 143.859 33.584C145.096 34.7787 146.44 35.6107 147.891 36.08C149.342 36.5067 151.134 36.72 153.267 36.72C158.131 36.72 161.502 35.4613 163.379 32.944L164.787 34.224C162.44 37.168 158.6 38.64 153.267 38.64C147.934 38.64 144.115 37.1253 141.811 34.096Z" fill="white"/>
				<path d="M197.37 38H195.45V19.44H176.25V38H174.33V0.87999H176.25V17.52H195.45V0.87999H197.37V38Z" fill="white"/>
				<path d="M212.91 36.08H233.773L220.654 5.16799L206.702 38H204.654L220.654 0.23999L236.654 38H212.91V36.08Z" fill="white"/>
				<path d="M267.955 0.87999V2.79999H254.515V38H252.595V2.79999H239.155V0.87999H267.955Z" fill="white"/>
			</g>
			<defs>
				<filter id="filter0_d_2_41" x="0.479996" y="0.23999" width="271.475" height="46.4" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
					<feFlood flood-opacity="0" result="BackgroundImageFix"/>
					<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
					<feOffset dy="4"/>
					<feGaussianBlur stdDeviation="2"/>
					<feComposite in2="hardAlpha" operator="out"/>
					<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
					<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_2_41"/>
					<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_2_41" result="shape"/>
				</filter>
			</defs>
		</svg>
        </a>

        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navmenu"
        >
          <span class="navbar-toggler-icon"><i class="bi bi-list text-white h1 m-0"></i></span>
        </button>

        <div class="collapse navbar-collapse ps-2 pe-2" id="navmenu">
          <ul class="navbar-nav ms-auto bg-sm-transparent">
            <li class="nav-item ps-2">
              <a href="/chatrooms" class="nav-link text-white"><i class="bi bi-people-fill nav-icon"></i> CHATROOMS</a>
            </li>
            
            <li class="nav-item ps-2">
            	 <c:choose>
            		<c:when test="${id == null}">
                		<a href="/accounts/login" class="nav-link text-white"><i class="bi bi-shield-lock-fill nav-icon"></i> LOG IN</a>
                	</c:when>
                	<c:otherwise>
                		<a href="/logout" class="nav-link text-white"><i class="bi bi-shield-lock-fill nav-icon"></i> LOGOUT</a>
                	</c:otherwise>
                </c:choose>
            </li>
            
          </ul>
        </div>
      </div>
    </nav>
 <jsp:doBody/>
</body>
</html>