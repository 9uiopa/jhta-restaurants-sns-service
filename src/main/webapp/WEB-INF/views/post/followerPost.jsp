<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<%@ include file="../common/navbar.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.
    googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <style type="text/css">
        img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            filter: brightness(70%);
        }

        .card-img-overlay {
            position: absolute;
            top: 30%;
            font-size: 22px;
        }
    </style>
    <title>Insert title here</title>
</head>
<body>
<div class="wrap">
    <div class="container border-top mt-3">
        <div class="row text-center border-bottom">
            <div class="col-12 my-5">
                <h2>Follower Post</h2>
                <h4 class="text-secondary">( 내가 팔로우한 사람들의 포스팅 확인해보세요! )</h4>
            </div>
        </div>
    </div>
    <div class="container justify-content-center align-items-center">
        <div id="postsOutputArea" class="row mt-4 mb-3">
        </div>
        <div class="text-center">
            <div class="btn disabled border border-0">
                <div id="postsLoadingSpinner"
                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                     style="display: none;">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">

    let isPostFetching = false;
    let isPostLast = false;
    const postsLoadingSpinner = document.getElementById('postsLoadingSpinner')

    let pageOnPosts = 1;

    const getPosts = (page) => {
        return fetch(`/post/get/followerPost?page=\${page}&limit=4`).then(response => response.json());
    }

    function fetchAndRenderPosts(currentPage) {

        isPostFetching = true;
        postsLoadingSpinner.style.display = 'block';

        getPosts(currentPage).then(data => {

            if (data.length < 4) {
                isPostLast = true;
                postsLoadingSpinner.style.display = 'none';
            }

            data.forEach(datum => {
                document.getElementById('postsOutputArea').innerHTML += `
            					<div class="col-md-4 my-3">
            						<div class="card text-center text-light font-weight-bold shadow" onclick="location.href='detail?id=\${datum.id}'" style=" cursor: pointer;">
            							<img src="../resources/image/cafe1.jpg" class="card-img-top rounded" alt="...">
            							<div class="card-img-overlay">
            								<p><strong>\${datum.title}</strong></p>
            							</div>
            						</div>
            						<div class="row">
            							<div class="col">
            								<strong >\${datum.customer.username}</strong>
            							</div>
            							<div class="col text-end">
            								\${timeForToday(datum.createDate)}
            							</div>
            						</div>
            					</div>
                `
                isPostFetching = false;
            })
        })
    }

    window.onscroll = function () {
        console.log(window.innerHeight)
        console.log(window.scrollY)
        console.log(document.body.offsetHeight)

        if ((window.innerHeight + window.scrollY) + .5 >= document.body.offsetHeight) {

            if (isPostFetching || isPostLast) {
                // do nothing;
            } else {
                pageOnPosts += 1;
                fetchAndRenderPosts(pageOnPosts);
            }
        }
    }

    // initial fetching and rendering
    fetchAndRenderPosts(pageOnPosts);

    function timeForToday(value) {
        const today = new Date();
        const timeValue = new Date(value);
        const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);

        if (betweenTime < 1) return '방금전';
        if (betweenTime < 60) {
            return `\${betweenTime}분전`;
        }

        const betweenTimeHour = Math.floor(betweenTime / 60);
        if (betweenTimeHour < 24) {
            return `\${betweenTimeHour}시간전`;
        }

        const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
        if (betweenTimeDay < 365) {
            return `\${betweenTimeDay}일전`;
        }

        return `\${Math.floor(betweenTimeDay / 365)}년전`;
    }

    $("[id^=dateInput]").each(function (index, input) {
        let value = $(input).val();
        let elapsed = timeForToday(value);
        $(input).next().text(elapsed);
    })
</script>
</body>
</html>