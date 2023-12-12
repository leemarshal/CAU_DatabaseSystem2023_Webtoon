"use client";
import axios from "axios";
import { getCookie } from "cookies-next";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default () => {
  const [loginForm, setLoginForm] = useState({ id: "", pw: "" });
  const [errorMessage, setErrorMessage] = useState<undefined | string>(
    undefined
  );
  const [errorShow, setErrorShow] = useState(false);

  const router = useRouter();

  const signIn = async () => {
    if (loginForm.id == "" || loginForm.pw == "") {
      setErrorShow(true);
    }
    try {
      const loginResult = await axios.post("/api/login", loginForm);
      if (loginResult.data.token) {
        router.push("/");
      }
      console.log(getCookie("token"));
    } catch (e) {
      if (axios.isAxiosError(e)) {
        setErrorMessage(e.response?.data);
      }
    }
  };

  return (
    <div className="h-screen flex">
      <div className="justify-center items-center w-full max-w-xs m-auto">
        <form className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
          <div className="mb-4">
            <label className="block text-gray-700 text-sm font-bold mb-2">
              Username
            </label>
            <input
              className={`shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline ${
                errorShow && loginForm.id == "" ? "border-red-500" : ""
              }`}
              id="username"
              type="text"
              placeholder="Username"
              onChange={(e) =>
                setLoginForm({ ...loginForm, id: e.target.value })
              }
            />
            {errorShow && loginForm.id == "" ? (
              <p className="text-red-500 text-xs italic">Please enter an id.</p>
            ) : (
              <></>
            )}
          </div>
          <div className="mb-6">
            <label className="block text-gray-700 text-sm font-bold mb-2">
              Password
            </label>
            <input
              className={`shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline ${
                errorShow && loginForm.pw == "" ? "border-red-500" : ""
              }`}
              id="password"
              type="password"
              placeholder="******************"
              onChange={(e) =>
                setLoginForm({ ...loginForm, pw: e.target.value })
              }
            />
            {errorShow && loginForm.pw == "" ? (
              <p className="text-red-500 text-xs italic">
                Please enter a password.
              </p>
            ) : (
              <></>
            )}
          </div>
          <div className="flex items-center justify-between">
            <button
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              type="button"
              onClick={signIn}
            >
              Sign In
            </button>
          </div>
          <div>{errorMessage}</div>
        </form>
        <p className="text-center text-gray-500 text-xs">
          &copy;2020 Acme Corp. All rights reserved.
        </p>
      </div>
    </div>
  );
};
