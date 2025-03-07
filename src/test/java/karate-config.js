function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'karatetrain@test.com'
    config.userPassword = 'Karate123'
  } else if (env == 'qa') {
    config.userEmail = 'karatetrain2@test.com'
    config.userPassword = 'Karate456'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})
  return config;
}