// For Firebase JS SDK v7.20.0 and later, measurementId is optional
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

const firebaseConfig<dynamic, String> {
  apiKey: "AIzaSyBITS1fLW-48_3_RA-ngxQIPKMri_jWrtI",
  authDomain: "seraphic-being-303723.firebaseapp.com",
  databaseURL: "https://seraphic-being-303723-default-rtdb.firebaseio.com",
  projectId: "seraphic-being-303723",
  storageBucket: "seraphic-being-303723.appspot.com",
  messagingSenderId: "659788470466",
  appId: "1:659788470466:web:203c9568225a8204db835b",
  measurementId: "G-E9NDZNPRKK"
};

  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.getAnalytics(app);