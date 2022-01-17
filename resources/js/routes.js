import auth from './middleware/auth';
import auth_client from './middleware/auth-client';
import guest from './middleware/guest';
import client from './middleware/client';

function page(path) {
    return () =>
        import(`./pages/${path}`).then(
            m => m.default || m
        );
}

// Routes
const routes = [
    {
        path: '/',
        meta: { layout: 'home' },
        component: page('public/Home.vue'),
        name: 'home'
    },
    {
        path: '/home-dashboard',
        meta: { layout: 'home', middleware: auth_client },
        component: page('public/Dashboard.vue'),
        name: 'homeDashboard',
    },
    {
        path: '/login',
        meta: { layout: 'auth', middleware: client },
        component: page('auth/Login.vue'),
        name: 'login',
    }, {
        path: '/register',
        meta: { layout: 'auth', middleware: client },
        component: page('auth/Register.vue'),
        name: 'register',
    }, 
    {
        path: '/faq',
        meta: { layout: 'home'},
        component: page('public/Faq.vue'),
        name: 'faq',
    },
    {
        path: '/privacy-policy',
        meta: { layout: 'home'},
        component: page('public/PrivacyPolicy.vue'),
        name: 'privacy',
    },
    {
        path: '/portfolio/:username',
        meta: { layout: 'home'},
        component: page('public/Portfolio.vue'),
        name: 'portfolio',
    },
    {
        path: '/chat',
        alias: '',
        meta: { layout: 'home', middleware: auth_client },
        component: page("public/chat/Chat.vue"),
        name: 'chat',
    },
    {
        path: '/overview/:slug',
        alias: '',
        meta: { layout: 'main' },
        component: page('public/Overview.vue'),
        name: 'overview',
    },
    {
        path: '/solution/:slug',
        alias: '',
        meta: { layout: 'main' },
        component: page('public/SolutionList.vue'),
        name: 'solution',
    },
    {
        path: '/get-detail-solution/:id',
        alias: '',
        meta: { layout: 'main' },
        component: page('public/SolutionDetail.vue'),
        name: 'showDetailSolution',
    },
    {
        path: '/add-solution/:slug',
        meta: { layout: 'main', middleware: auth_client },
        component: page('public/AddSolution.vue'),
        name: 'addSolution',
    },
    {
        path: '/edit-solution/:slug',
        meta: { layout: 'main', middleware: auth_client },
        component: page('public/EditSolution.vue'),
        name: 'editSolution',
    },
    {
        path: '/feedback/:slug',
        alias: '',
        meta: { layout: 'main' },
        component: page('public/Feedback.vue'),
        name: 'feedback',
    },
    {
        path: '/chanllenge/:slug',
        alias: '',
        meta: { layout: 'main' },
        component: page('public/Chanllenge.vue'),
        name: 'chanllenge',
    },
    {
        path: "/payment/:upgrade_id",
        meta: { layout: 'home', middleware: auth_client },
        component: page("public/Payment.vue"),
        name: "payment"
    },
    {
        path: "/profile",
        meta: { layout: 'home', middleware: auth_client },
        component: page("public/Profile.vue"),
        name: "profile"
    },
    {
        path: "/settings",
        meta: { layout: 'home', middleware: auth_client },
        component: page("public/Setting.vue"),
        name: "settings"
    },
    {
        path: '/premium',
        meta: { layout: 'home' },
        component: page('public/Premium.vue'),
        name: 'premium',
    },
    {
        path: '/order/:id',
        meta: { layout: 'home' },
        component: page('public/Order.vue'),
        name: 'order',
    },
    {
        path: '/notification',
        meta: { layout: 'home' },
        component: page('public/Notification.vue'),
        name: 'notification',
    },
    {
        path: '/admin',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/dashboard/Dashboard.vue"),
        name: 'dashboard',
    },
    {
        path: '/admin/users',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/user/User.vue"),
        name: 'users',
    },
    {
        path: '/admin/user-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/user/AddUser.vue"),
        name: 'add.user',
    },
    {
        path: '/admin/user-edit/:id',
        meta: { layout: 'admin', middleware: auth },

        component: page("admin/user/EditUser.vue"),
        name: 'edit.user',
    },
    {
        path: '/admin/roles',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/role/Role.vue"),
        name: 'roles',
    },
    {
        path: '/admin/role-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/role/AddRole.vue"),
        name: 'add.role',
    },
    {
        path: '/admin/role-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/role/EditRole.vue"),
        name: 'edit.role',
    },
    {
        path: '/admin/permissions',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/permission/Permission.vue"),
        name: 'permissions',
    },
    {
        path: '/admin/permission-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/permission/AddPermission.vue"),
        name: 'add.permission',
    },
    {
        path: '/admin/permission-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/permission/EditPermission.vue"),
        name: 'edit.permission',
    },
    {
        path: '/admin/challengecategories',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/challengeCategory/challengeCategory.vue"),
        name: 'challengecategories',
    },
    {
        path: '/admin/challengecategory-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/challengeCategory/AddchallengeCategory.vue"),
        name: 'add.challengecategory',
    },
    {
        path: '/admin/challengecategory-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/challengeCategory/EditchallengeCategory.vue"),
        name: 'edit.challengecategory',
    }, {
        path: '/admin/challenges',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/challenge/Challenge.vue"),
        name: 'challenges'
    },
    {
        path: '/admin/challenge-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/challenge/AddChallenge.vue"),
        name: 'add.challenge'
    },
    {
        path: '/admin/challenge-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/challenge/EditChallenge.vue"),
        name: 'edit.challenge'
    },
    {
        path: '/admin/solutions',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/solution/Solution.vue"),
        name: 'solutions'
    },
    {
        path: '/admin/solution-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/solution/EditSolution.vue"),
        name: 'edit.solution'
    },
    {
        path: '/admin/feedback-add/:parent_id/:solution_id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/feedback/AddFeedback.vue"),
        name: 'add.feedback'
    },
    {
        path: '/admin/feedbacks',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/feedback/Feedback.vue"),
        name: 'feedbacks'
    },
    {
        path: '/admin/chat',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/chat/Chat.vue"),
        name: 'admin.chat'
    },
    {
        path: '/admin/private-chat',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/chat/PrivateChat.vue"),
        name: 'admin.private-chat'
    },
    {
        path: '/admin/mentors',
        meta: { layout: 'admin', middleware: auth },
        component: page('admin/mentor/Mentor.vue'),
        name: 'mentors'
    },
    {
        path: '/admin/mentor-add',
        meta: { layout: 'admin', middleware: auth },
        component: page('admin/mentor/AddMentor.vue'),
        name: 'add.mentor'
    },
    {
        path: '/admin/mentor-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page('admin/mentor/EditMentor.vue'),
        name: 'edit.mentor'
    },
    {
        path: '/admin/login',
        meta: { layout: 'admin-login', middleware: guest },
        component: page('auth/LoginAdmin.vue'),
        name: 'admin.login'
    },
    {
        path: '/admin/profile',
        meta: { layout: 'admin', middleware: auth },
        component: page('admin/profile/ProfileAdmin.vue'),
        name: 'admin.profile'
    },
    {
        path: '/admin/orders',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/order/Order.vue"),
        name: 'admin.orders',
    },
    {
        path: '/admin/order-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/order/AddOrder.vue"),
        name: 'add.order',
    },
    {
        path: '/admin/order-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/order/EditOrder.vue"),
        name: 'edit.order',
    },
    {
        path: '/admin/upgrades',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/upgrade/Upgrade.vue"),
        name: 'admin.upgrades',
    },
    {
        path: '/admin/upgrade-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/upgrade/AddUpgrade.vue"),
        name: 'add.upgrade',
    },
    {
        path: '/admin/upgrade-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/upgrade/EditUpgrade.vue"),
        name: 'edit.upgrade',
    },
    {
        path: '/admin/notifications',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/notification/Notification.vue"),
        name: 'admin.notifications',
    },
    {
        path: '/admin/notification',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/profile/Notification.vue"),
        name: 'admin.notification',
    },
    {
        path: '/admin/notification-add',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/notification/AddNotification.vue"),
        name: 'add.notification',
    },
    {
        path: '/admin/notification-edit/:id',
        meta: { layout: 'admin', middleware: auth },
        component: page("admin/notification/EditNotification.vue"),
        name: 'edit.notification',
    },
    {
        path: '/forgot-password',
        meta: { layout: 'auth', middleware: guest },
        component: page("auth/ForgotPassword.vue"),
        name: 'forgot.pass',
    },
    {
        path: '/reset-password/:token',
        meta: { layout: 'auth', middleware: guest },
        component: page("auth/ResetPassword.vue"),
        name: 'reset.pass',
    },
    {
        // not found handler
        path: '*',
        component: page("errors/404.vue"),

    }
]


export default routes