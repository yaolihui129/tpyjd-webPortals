requirejs.config({
    baseUrl: '/resource/js',
    shim: {
        jquery: {
            exports: "$"
        },
        common: {
            deps: ['jquery']
        },
        yzm: {
            deps: ['jquery']
        },
        formValidate: {
            deps: ['jquery']
        },
        lay : {
        	deps: ['jquery']
        },
        laydate : {
        	deps: ['jquery']
        }

    },
    paths: {
        'jquery': 'system/jquery-2.2.0.min',
        'swiper': 'system/swiper.min',
        'common': 'modules/common',
        'yzm': 'modules/yzm',
        'formValidate': 'modules/formValidate',
        'swiper-animate': 'system/swiper.animate1.0.2.min',
        'nep': 'system/nep.min',
        'lay': 'system/layer',
        'laydate' : 'system/laydate'
    }
});