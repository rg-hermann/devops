'use strict';

exports.handler = (event, context, callback) => {
	const response = event.Records[0].cf.response;
	const headers = response.headers;

	headers['strict-transport-security'] = [{ key: 'Strict-Transport-Security', value: 'max-age=63072000; includeSubdomains; preload' }];
	const securityPolicies = {
		'default-src': ["'self'"],
		'img-src': [
			"'self'",

		],
		'font-src': [
			"'self'",
		],
		'connect-src': [
			"'self'",
		],
		'style-src': [
			"'self'",
		],
		'media-src': [
			"'self'",
		],
		'script-src': [
			"'self'",
		],
		'script-src-elem': [
			"'self'",
		],
		'frame-ancestors': [
			"'self'",
		],
		'frame-src': [
			"'self'",
		],
		'form-action': [
			"'self'",
		],
		'base-uri': [
			"'self'",
		],
		'object-src': [
			"'none'",
		],
		'manifest-src': [
			"'self'",
		],
	}

	const contentSecurityPolicyValue = Object.keys(securityPolicies)
		.map(directive => `${directive} ${securityPolicies[directive].join(' ')}`)
		.join('; ');

	headers['content-security-policy'] = [{ key: 'Content-Security-Policy', value: `${contentSecurityPolicyValue};` }];
	headers['x-content-type-options'] = [{ key: 'X-Content-Type-Options', value: 'nosniff' }];
	headers['x-frame-options'] = [{ key: 'X-Frame-Options', value: 'SAMEORIGIN' }];
	headers['x-xss-protection'] = [{ key: 'X-XSS-Protection', value: '1; mode=block' }];
	headers['referrer-policy'] = [{ key: 'Referrer-Policy', value: 'origin' }];

	callback(null, response);
};