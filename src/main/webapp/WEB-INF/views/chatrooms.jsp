<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<t:base>

    <noscript>
        <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>

    <div id="username-page" class="fade-in d-flex align-items-center text-white">
        <div class="container username-page-container text-center pt-5 pb-3 vh-100">
            <h1 class="my-5">Select your room</h1>
            <form action="/chatrooms/enter" method="post" chatroomNameForm" name="chatroomNameForm" class="chatroomSelection">
                <!-- <div class="d-flex gap-3"> -->
                        <!-- <div class="form-check">
                            <input class="form-check-input" type="radio" name="chatRoomName" id="room" value="room1" checked>
                            <label class="form-check-label" for="room1">Room 1</label>
                        </div> -->
                        <!-- <div class="form-check">
                            <input class="form-check-input" type="radio" name="chatRoomName" id="room" value="room2">
                            <label class="form-check-label" for="room2">Room 2</label>
                        </div> -->
                        <!-- <div class="form-group">
                            <label for="chatroomName">Chat Room</label>
                            <input type="text" class="form-control" id="chatroomName" name="chatroomName" placeholder="Enter Room Name">
                        </div> -->
                <!-- </div> -->
                <div class="row styled-text text-white mt-1">
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Pets & Animals</p>
						<input type="radio" name="chatroomName" id="petsAnimals" value="Pets & Animals" checked="checked">
                        <label class="category-image petsAnimals" for="petsAnimals"></label>                       
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Health & Nutrition</p>
						<input type="radio" name="chatroomName" id="healthNutrition" value="Health & Nutrition">
                        <label class="category-image healthNutrition" for="healthNutrition"></label>                       
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Anime</p>
						<input type="radio" name="chatroomName" id="anime" value="Anime">
                        <label class="category-image anime" for="anime"></label>                    
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Food & Recipes</p>
						<input type="radio" name="chatroomName" id="foodRecipes" value="Food & Recipes">
                        <label class="category-image foodRecipes" for="foodRecipes"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Videogames</p>
						<input type="radio" name="chatroomName" id="videogames" value="Videogames">
                        <label class="category-image videogames" for="videogames"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Horticulture</p>
						<input type="radio" name="chatroomName" id="horticulture" value="Horticulture">
                        <label class="category-image horticulture" for="horticulture"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Music</p>
						<input type="radio" name="chatroomName" id="music" value="Music">
                        <label class="category-image music" for="music"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Gay Pride</p>
						<input type="radio" name="chatroomName" id="gayPride" value="Gay Pride">
                        <label class="category-image gayPride" for="gayPride">️‍</label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Photography</p>
						<input type="radio" name="chatroomName" id="photography" value="Photography">
                        <label class="category-image photography" for="photography"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Sports</p>
						<input type="radio" name="chatroomName" id="sports" value="Sports">
                        <label class="category-image sports" for="sports"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Comedy</p>
						<input type="radio" name="chatroomName" id="comedy" value="Comedy">
                        <label class="category-image comedy" for="comedy"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Veterans</p>
						<input type="radio" name="chatroomName" id="veterans" value="Veterans">
                        <label class="category-image veterans" for="veterans"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Crypto</p>
						<input type="radio" name="chatroomName" id="crypto" value="Crypto">
                        <label class="category-image crypto" for="crypto"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>History</p>
						<input type="radio" name="chatroomName" id="history" value="History">
                        <label class="category-image history" for="history"></label>
					</div>
					<div class="col-sm-6 col-md-4 col-lg-3 category-selector">
						<p>Parenthood</p>
						<input type="radio" name="chatroomName" id="parenthood" value="Parenthood">
                        <label class="category-image parenthood" for="parenthood"></label>
					</div>
				</div>
          

                <div class="form-group fixed-bottom mb-3">
                    <button type="submit" class="username-submit styled-button btn btn-light btn-lg w-md-21 w-lg-16 w-xl-14 w-xxl-12">Let's Chat <i class="bi-arrow-right-short"></i></button>
                </div>
    
            </form>
        </div>
    </div>
    
    
</t:base>