package kr.co.jhta.restaurants_service.controller.users;

import kr.co.jhta.restaurants_service.controller.command.OtpCommand;
import kr.co.jhta.restaurants_service.controller.command.UserCommand;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.security.domain.SecurityUser;
import kr.co.jhta.restaurants_service.security.service.UserService;
import kr.co.jhta.restaurants_service.service.OtpService;
import kr.co.jhta.restaurants_service.service.PostService;
import kr.co.jhta.restaurants_service.service.ReviewService;
import kr.co.jhta.restaurants_service.service.SocialService;
import kr.co.jhta.restaurants_service.vo.post.Post;
import kr.co.jhta.restaurants_service.vo.review.Review;
import kr.co.jhta.restaurants_service.vo.user.Otp;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.jboss.logging.Logger;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    public static String[] PUBLIC_URLS = {
            "/customer/signup",
            "/customer/otp",
            "/customer/otp-check",
            "/customer/details"
    };
    private final UserService userService;
    private final OtpService otpService;
    private final PostService postService;
    private final SocialService socialService;
    private final ReviewService reviewService;
    Logger logger = Logger.getLogger(UserController.class);

    public CustomerController(UserService userService, OtpService otpService, PostService postService, SocialService socialService, ReviewService reviewService) {
        this.userService = userService;
        this.otpService = otpService;
        this.postService = postService;
        this.socialService = socialService;
        this.reviewService = reviewService;
    }

    @ResponseBody
    @GetMapping("/reviews")
    public ResponseEntity<Page<Projection.Review>> reviews(@AuthenticationPrincipal SecurityUser securityUser,
                                                         @RequestParam("page") Optional<Integer> page,
                                                         @RequestParam("limit") Optional<Integer> limit) {
        Page<Projection.Review> reviews =
                reviewService.getNonBlockedReviewsByCustomerIdOrderByCreateDate(
                        securityUser.getUser().getId(),
                        Review.BLOCKED.NO,
                        page.orElse(0),
                        limit.orElse(10)
                );

        return ResponseEntity.of(Optional.ofNullable(reviews));
    }

    @ResponseBody
    @GetMapping("/posts")
    public ResponseEntity<Page<Projection.Post>> posts(@AuthenticationPrincipal SecurityUser securityUser,
                                                       @RequestParam("page") Optional<Integer> page,
                                                       @RequestParam("limit") Optional<Integer> limit) {
        Page<Projection.Post> posts =
                postService.getNonBlockedPostsByCustomerIdOrderByCreateDate(
                        securityUser.getUser().getId(),
                        Post.BLOCKED.NO,
                        page.orElse(0),
                        limit.orElse(10)
                );

        return ResponseEntity.of(Optional.ofNullable(posts));
    }

    @ResponseBody
    @GetMapping("/followers")
    public ResponseEntity<List<Projection.User>> followers(@AuthenticationPrincipal SecurityUser securityUser,
                                                           @RequestParam("page") Optional<Integer> page,
                                                           @RequestParam("limit") Optional<Integer> limit) {

        List<Projection.User> followers =
                socialService.getNonDisabledFollowersByCustomerIdOrderByCreateDate(
                        securityUser.getUser().getId(),
                        User.DISABLED.NO,
                        page.orElse(0),
                        limit.orElse(10)
                );

        return ResponseEntity.of(Optional.ofNullable(followers));
    }

    @ResponseBody
    @PostMapping(value = "/otp-check", consumes = "application/json")
    public ResponseEntity otpCheck(@RequestBody OtpCommand otpCommand, HttpSession session) {

        UserCommand userCommand = Optional.ofNullable((UserCommand) session.getAttribute("userCommand")).orElse(null);
        logger.info(userCommand.getFullName());

        boolean isValid = otpService.validateOtp(otpCommand);

        if (isValid) {
            userService.insertCustomer(userCommand);
            session.setAttribute("userCommand", null);

            return ResponseEntity.ok("Valid otp!");
        } else {
            session.setAttribute("userCommand", null);
            return ResponseEntity.badRequest().body("Invalid otp!");
        }
    }

    @ResponseBody
    @GetMapping("/otp")
    public ResponseEntity otpIssue(@RequestParam("email") String email) {

        Otp otp = otpService.issueOtp(email);

        return ResponseEntity.ok().body("Otp got successfully issued");
    }

    @ResponseBody
    @PostMapping(value = "/signup", consumes = "application/json")
    public ResponseEntity signup(@RequestBody UserCommand userCommand, HttpSession session) {

        session.setAttribute("userCommand", userCommand);

        return null;
    }

    @GetMapping("/signup")
    public String signupForm(HttpSession httpSession) {

        return "user/customer/signup-form";
    }

    @GetMapping("/my-page")
    public String myPage(@AuthenticationPrincipal SecurityUser securityUser, Model model) {

        model.addAttribute("customer", securityUser.getUser());

        return "/user/customer/my-page";
    }
}
