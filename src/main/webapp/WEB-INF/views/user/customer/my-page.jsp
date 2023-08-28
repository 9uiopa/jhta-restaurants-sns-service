<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Application</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<%@ include file="../../common/navbar.jsp" %>
<div class="container">
    <div class="row my-5">
        <div class="col-md-5 my-5">
            <div class="card shadow my-3">
                <div class="fw-lighter m-3 p-1">
                    <div class="row">
                        <div class="col fs-4">About Me</div>
                    </div>
                    <div class="row">
                        <div class="col text-end">
                            <div id="postsToastButton" type="button"
                                 class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                posts
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${postsCount}
                                </span>
                            </div>
                            <div id="reviewsToastButton" type="button"
                                 class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                reviews
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${reviewsCount}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row mx-2">
                        <div class="col-sm-4 my-1 fw-lighter">
                            <label for="fullName" class="col-sm-2 col-form-label"><span style="white-space: nowrap">Full Name</span></label>
                        </div>
                        <div class="col-sm-8 my-1">
                            <p class="form-control-plaintext" id="fullName"> ${ customer.fullName } </p>
                        </div>
                    </div>
                    <div class="row mx-2">
                        <div class="col-sm-4 my-1 fw-lighter">
                            <label for="nickName" class="col-sm-2 col-form-label"><span style="white-space: nowrap">Nickname</span></label>
                        </div>
                        <div class="col-sm-8 my-1">
                            <p class="form-control-plaintext" id="nickName"> ${ customer.nickname } </p>
                        </div>
                    </div>
                    <div class="row mx-2">
                        <div class="col-sm-4 my-1 fw-lighter">
                            <label for="email" class="col-sm-2 col-form-label"><span
                                    style="white-space: nowrap">Email</span></label>
                        </div>
                        <div class="col-sm-8 my-1">
                            <p class="form-control-plaintext" id="email"> ${ customer.email } </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card shadow my-3">
                <div class="fw-lighter m-3 p-1">
                    <div class="row">
                        <div class="col-8 fs-4">Socials</div>
                        <div class="col-4 d-flex justify-content-end">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch"
                                       id="flexSwitchCheckDefault">
                                <label class="form-check-label" for="flexSwitchCheckDefault">Private</label>
                            </div>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col text-end">
                            <div id="followersToastButton" type="button"
                                 class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                followers
                                <span id="followersCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                            </div>
                            <div id="followingsToastButton" type="button"
                                 class="badge bg-secondary-subtle border border-secondary-subtle text-secondary-emphasis rounded-pill position-relative mx-2">
                                followings
                                <span id="followingsCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
<%--                    // TODO: Buttons categorization into 'PENDING' / 'ACCEPTED' / 'DENIED' / 'SENT'--%>
                    <div class="p-2 m-3">
                        <div id="arrivedRequests"
                             type="button"
                             class="badge bg-primary-subtle border border-primary-subtle text-primary-emphasis rounded-pill ">
                            Arrived requests
                        </div>
                        <div id="sentRequests"
                             type="button"
                             class="badge bg-success-subtle border border-success-subtle text-success-emphasis rounded-pill ">
                            Sent requests
                        </div>
                        <hr/>
                        <div id="requestsOutputArea" class="overflow-scroll" style="max-height: 200px">
                        </div>
                        <div class="text-center">
                            <div class="btn border border-0 disabled">
                                <div id="requestLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-7 my-5">
            <div class="card shadow overflow-auto my-3">
                <div class="d-flex fs-4 m-3 p-1 fw-lighter ">Some Contents..
                </div>
                <div class="card-body">
                    Some Contents..
                </div>
            </div>
        </div>
    </div>
</div>
<div class="toast-container position-fixed bottom-0 end-0 p-4">
    <div id="successfulToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
    <div id="postsToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Posts
                            <div class="btn border border-0 disabled">
                                <div id="postsLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="postsCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="postsOutputArea" class="bg-light-subtle my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
    <div id="reviewsToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Reviews
                            <div class="btn border border-0 disabled">
                                <div id="reviewsLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="reviewsCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="reviewsOutputArea" class="bg-light-subtle my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
    <div id="followersToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Followers

                            <div class="btn border border-0 disabled">
                                <div id="followersLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="followersCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="followersOutputArea" class="my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
    <div id="followingsToast" class="toast toast-add-menu" role="alert" aria-live="assertive" aria-atomic="true"
         data-bs-autohide="false">
        <div class="toast-body">
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="fw-lighter fs-4">Followings
                            <div class="btn border border-0 disabled">
                                <div id="followingsLoadingSpinner"
                                     class="spinner-border spinner-border-sm text-primary m-1" role="status"
                                     style="display: none;">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </div>
                        <button id="followingsCloseButton" type="button" class="btn-close" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </div>
            <div id="followingsOutputArea" class="my-2 p-1" style="max-height: 400px; overflow-y: auto;">
            </div>
        </div>
    </div>
</div>
</body>
<script>

    function accept(senderId) {

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/follow/accept?sender-id=" + senderId, true);
        xhr.responseType = "text";

        xhr.onload = function () {
            if (xhr.status === 200) {
                alert("success message")
                window.location.reload();
            } else {
                alert(xhr.responseText);
            }
        };

        xhr.send();

    }

    function decline(senderId) {

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/follow/decline?id=" + senderId, true);
        xhr.responseType = "text";

        xhr.onload = function () {
            if (xhr.status === 200) {
                alert("success message")
            } else {
                alert(xhr.responseText);
            }
        };

        xhr.send();
    }

    document.addEventListener("DOMContentLoaded", function () {

        const followersToastButton = document.getElementById('followersToastButton')
        const followersLoadingSpinner = document.getElementById('followersLoadingSpinner')
        const followersCloseButton = document.getElementById('followersCloseButton');

        let followersToast = document.getElementById('followersToast')
        let followersOutputArea = document.getElementById('followersOutputArea');

        const followingsToastButton = document.getElementById('followingsToastButton')
        const followingsLoadingSpinner = document.getElementById('followingsLoadingSpinner')
        const followingsCloseButton = document.getElementById('followingsCloseButton');

        let followingsToast = document.getElementById('followingsToast')
        let followingsOutputArea = document.getElementById('followingsOutputArea');

        const postsToastButton = document.getElementById('postsToastButton')
        const postsLoadingSpinner = document.getElementById('postsLoadingSpinner')
        let postsToast = document.getElementById('postsToast')
        let postOutputArea = document.getElementById('postsOutputArea');

        const reviewsToastButton = document.getElementById('reviewsToastButton')
        const reviewsLoadingSpinner = document.getElementById('reviewsLoadingSpinner')
        let reviewsToast = document.getElementById('reviewsToast')
        let reviewsOutputArea = document.getElementById('reviewsOutputArea');

        let pageOnFollower = 0
        let isFollowerFetching = false;
        let isFollowerLast = false;

        let pageOnFollowing = 0
        let isFollowingFetching = false;
        let isFollowingLast = false;

        let pageOnPost = 0
        let isPostFetching = false;
        let isPostLast = false;

        let pageOnReview = 0
        let isReviewFetching = false;
        let isReviewLast = false;

        postsToastButton.addEventListener("click", function () {
            const postsToastBootstrap = bootstrap.Toast.getOrCreateInstance(postsToast)

            // initial loading
            fetchAndRenderPosts(pageOnPost);

            // infinite scrolling (scroll pagination)
            postOutputArea.addEventListener('scroll', function () {
                const scrollPos = this.scrollTop + this.clientHeight;
                const scrollHeight = this.scrollHeight;

                if (scrollPos === scrollHeight) {
                    pageOnPost += 1;
                    fetchAndRenderPosts(pageOnPost);
                }
            })

            postsToastBootstrap.show()
        })

        reviewsToastButton.addEventListener("click", function () {
            const reviewsToastBootstrap = bootstrap.Toast.getOrCreateInstance(reviewsToast)

            // initial loading
            fetchAndRenderReviews(pageOnReview);

            // infinite scrolling (scroll pagination)
            reviewsOutputArea.addEventListener('scroll', function () {
                const scrollPos = this.scrollTop + this.clientHeight;
                const scrollHeight = this.scrollHeight;

                if (scrollPos === scrollHeight) {
                    pageOnReview += 1;
                    fetchAndRenderReviews(pageOnReview);
                }
            })

            reviewsToastBootstrap.show()
        })

        const getFollowers = page => {
            return fetch(`/customer/followers?page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderFollowers(page) {
            if (isFollowerFetching || isFollowerLast) {
                return;
            }
            isFollowerFetching = true;
            followersLoadingSpinner.style.display = 'block';
            getFollowers(page).then(data => {
                if (data.length === 0) {
                    followersOutputArea.innerHTML += `<span class=fw-lighter m-3>No followers yet.</span>`
                    followersLoadingSpinner.style.display = 'none'
                    isFollowerFetching = false;
                }

                // where 7 is the limit of the number of response on each request
                if (data.length < 7) {
                    isFollowerLast = true;
                }

                data.forEach(datum => {
                    followersOutputArea.innerHTML += `
                        <div class="shadow border border-light rounded m-3">
                            <div class="p-3">
                                <div class="fw-medium badge bg-primary-subtle text-primary-emphasis rounded-pill"> \${datum.nickname}</div>
                                <div>\${datum.email}</div>
                            </div>
                        </div>
                    `
                    followersLoadingSpinner.style.display = 'none'
                    isFollowerFetching = false;
                })
            })
        }

        followersToastButton.addEventListener("click", function () {
            const followersToastBootstrap = bootstrap.Toast.getOrCreateInstance(followersToast)

            // initial loading
            fetchAndRenderFollowers(pageOnFollower)

            // infinite scrolling (scroll pagination)
            followersOutputArea.addEventListener('scroll', function () {
                const scrollPos = this.scrollTop + this.clientHeight;
                const scrollHeight = this.scrollHeight

                if (scrollPos === scrollHeight) {
                    pageOnFollower += 1;
                    fetchAndRenderFollowers(pageOnFollower)
                }
            })

            followersToastBootstrap.show()
        })

        const getFollowings = page => {
            return fetch(`/customer/followings?page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderFollowings(page) {
            if (isFollowingFetching || isFollowingLast) {
                return;
            }
            isFollowingFetching = true;
            followingsLoadingSpinner.style.display = 'block';
            getFollowings(page).then(data => {
                if (data.length === 0) {
                    followingsOutputArea.innerHTML += `<span class=fw-lighter m-3>No followings yet.</span>`
                    followingsLoadingSpinner.style.display = 'none'
                    isFollowingFetching = false;
                }

                // where 7 is the limit of the number of response on each request
                if (data.length < 7) {
                    isFollowingLast = true;
                }

                data.forEach(datum => {
                    followingsOutputArea.innerHTML += `
                        <div class="shadow border border-light rounded m-3">
                            <div class="p-3">
                                <div class="fw-medium badge bg-primary-subtle text-primary-emphasis rounded-pill"> \${datum.nickname}</div>
                                <div>\${datum.email}</div>
                            </div>
                        </div>
                    `
                    followingsLoadingSpinner.style.display = 'none'
                    isFollowingFetching = false;
                })
            })
        }

        followingsToastButton.addEventListener("click", function () {
            const followingsToastBootstrap = bootstrap.Toast.getOrCreateInstance(followingsToast)

            // initial loading
            fetchAndRenderFollowings(pageOnFollowing)

            // infinite scrolling (scroll pagination)
            followingsOutputArea.addEventListener('scroll', function () {
                const scrollPos = this.scrollTop + this.clientHeight;
                const scrollHeight = this.scrollHeight

                if (scrollPos === scrollHeight) {
                    pageOnFollowing += 1;
                    fetchAndRenderFollowings(pageOnFollowing)
                }
            })

            followingsToastBootstrap.show()
        })

        followingsToastButton.addEventListener("click", function () {
            let followingsToast = document.getElementById('followingsToast')
            const followingsToastBootstrap = bootstrap.Toast.getOrCreateInstance(followingsToast)
            followingsToastBootstrap.show()
        })

        const getPosts = page => {
            return fetch(`/customer/posts?page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderPosts(page) {
            if (isPostFetching || isPostLast) {
                return;
            }
            isPostFetching = true;
            postsLoadingSpinner.style.display = 'block';
            getPosts(page).then(data => {

                if (data.totalElements === 0) {
                    postOutputArea.innerHTML += `<span class=fw-lighter m-3>No posts published yet.</span>`
                    postsLoadingSpinner.style.display = 'none'
                    isPostFetching = false;
                }

                isPostLast = data.last;
                data.content.forEach(datum => {
                    postOutputArea.innerHTML += `
                        <div class="shadow border border-light rounded m-3">
                            <div class="p-3">
                                <div class="fw-medium"> \${datum.title}</div>
                                \${datum.subTitle}
                            </div>
                            <div class="text-end m-2">
                                <i style="color: #cb444a" class="bi bi-trash m-2"></i>
                            </div>
                        </div>
                    `;
                    postsLoadingSpinner.style.display = 'none'
                    isPostFetching = false;
                })
            })
        }

        const getReviews = page => {
            return fetch(`/customer/reviews?page=\${page}&limit=7`).then(response => response.json());
        }

        function fetchAndRenderReviews(page) {
            if (isReviewFetching || isReviewLast) {
                return;
            }
            isReviewFetching = true;
            reviewsLoadingSpinner.style.display = 'block';
            getReviews(page).then(data => {

                if (data.totalElements === 0) {
                    reviewsOutputArea.innerHTML += `<span class=fw-lighter m-3>No reviews published yet.</span>`
                    reviewsLoadingSpinner.style.display = 'none'
                    isReviewFetching = false;
                }

                isReviewLast = data.last;
                data.content.forEach(datum => {
                    reviewsOutputArea.innerHTML += `
                        <div class="shadow border border-light rounded m-3">
                            <div class="p-3">
                                <div class="fw-medium"> \${datum.store.name} (\${datum.rating}) </div>
                                \${datum.content}
                            </div>
                            <div class="text-end m-2">
                                <i style="color: #cb444a" class="bi bi-trash m-2"></i>
                            </div>
                        </div>
                    `;
                    reviewsLoadingSpinner.style.display = 'none'
                    isReviewFetching = false;
                })
            })
        }


    });

    let isRequestLast = false;
    let isRequestsFetching = false;
    let pageOnRequests = 0
    let requestFetchingOption = 'arrived'

    const requestLoadingSpinner = document.getElementById('requestLoadingSpinner')
    const requestsOutputArea = document.getElementById('requestsOutputArea')

    const getRequests = (option, page) => {
        return fetch(`/customer/requests?option=\${option}&page=\${page}&limit=5`).then(response => response.json())
    }

    function fetchAndRenderRequests(option, page) {
        isRequestsFetching = true
        requestLoadingSpinner.style.display = 'block';

        getRequests(option, page).then(data => {

            if (data.length < 5) {
                isRequestLast = true;
                isRequestsFetching = false;
            }

            data.forEach(datum => {

                function getStatusClasses(status) {
                    switch (status) {
                        case 'PENDING':
                            return 'badge bg-success-subtle text-success-emphasis rounded-pill my-1 requestStatusButton';
                        case 'ACCEPTED':
                            return 'badge bg-primary-subtle text-primary-emphasis rounded-pill my-1 requestStatusButton';
                        case 'DECLINED':
                            return 'badge bg-danger-subtle text-danger-emphasis rounded-pill my-1 requestStatusButton';
                        default:
                            return 'badge bg-secondary rounded-pill my-1 requestStatusButton';
                    }
                }

                const statusClasses = getStatusClasses(datum.followRequest.status);

                requestsOutputArea.innerHTML += `
                <div class="border rounded p-2 my-2 d-flex align-items-center">
                    <div class="fw-light mx-1">\${datum.user.nickname}</div>
                    <div class="ms-auto">
                        <span type="button"
                              data-request-id="\${datum.followRequest.id}"
                              class="\${statusClasses}">\${datum.followRequest.status}</span>
                    </div>
                </div>

                `
                requestLoadingSpinner.style.display = 'none';
                isRequestsFetching = false;
            })
        })
    }

    fetchAndRenderRequests(requestFetchingOption, pageOnRequests);

    document.getElementById('sentRequests').addEventListener('click', function () {
        requestsOutputArea.innerHTML = ''

        pageOnRequests = 0
        isRequestLast = false;
        requestFetchingOption = 'sent'
        fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
    })

    document.getElementById('arrivedRequests').addEventListener('click', function () {
        requestsOutputArea.innerHTML = ''

        pageOnRequests = 0
        isRequestLast = false;
        requestFetchingOption = 'arrived'
        fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
    })

    requestsOutputArea.addEventListener('scroll', function () {

        const scrollPos = this.scrollTop + this.clientHeight;
        const scrollHeight = this.scrollHeight;

        if (scrollPos === scrollHeight) {

            if (isRequestsFetching || isRequestLast) {
                // do nothing
            } else {
                pageOnRequests += 1;
                fetchAndRenderRequests(requestFetchingOption, pageOnRequests);
            }

        }
    })

    document.addEventListener('click', function(event) {
        if (event.target.classList.contains('requestStatusButton')) {
            const button = event.target;
            const requestId = button.getAttribute('data-request-id')

            fetch(`/customer/requests-modify?requestId=\${requestId}`, {
                method: "POST"
            })
                .then(response => response.text())
                .then(status => {

                    function getStatusClasses(status) {
                        switch (status) {
                            case 'PENDING':
                                return 'badge bg-success-subtle text-success-emphasis rounded-pill my-1 requestStatusButton';
                            case 'ACCEPTED':
                                return 'badge bg-primary-subtle text-primary-emphasis rounded-pill my-1 requestStatusButton';
                            case 'DECLINED':
                                return 'badge bg-danger-subtle text-danger-emphasis rounded-pill my-1 requestStatusButton';
                            default:
                                return 'badge bg-secondary rounded-pill my-1 requestStatusButton';
                        }
                    }
                    const newStatusClasses = getStatusClasses(status);

                    button.textContent = status;
                    button.className = newStatusClasses;

                    updateFollowersCount();
                })
        }
    })

    const updateFollowersCount = () => {
        fetch(`/customer/followers-count`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('followersCount').textContent = data;
            });
    };
    updateFollowersCount();

    const updateFollowingsCount = () => {
        fetch(`/customer/followings-count`)
            .then(response => response.text())
            .then(data => {
                document.getElementById('followingsCount').textContent = data;
            });
    };
    updateFollowingsCount();

</script>
</html>
