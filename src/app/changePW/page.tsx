"use client";
import ToolBar from "@/app/cookie/components/ToolBar";
import axios from "axios";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function ChangePW() {
  const TOOLBAR_HEIGHT = 70;
  const [newPW1, setNewPW1] = useState("");
  const [newPW2, setNewPW2] = useState("");
  const router = useRouter();

  const submit = async () => {
    if (!newPW1 || !newPW2) {
      alert("비밀번호를 입력하세요.");
    } else if (newPW1 !== newPW2) {
      alert("비밀번호가 일치하지 않습니다.");
    } else {
      try {
        await axios.post("/api/changePW", { pw: newPW1 });
        alert("변경 완료. 다시 로그인해주세요");
        router.push("/login");
        router.refresh();
      } catch (e) {
        if (axios.isAxiosError(e)) {
          alert(e.message + e.response?.data);
        }
      }
    }
  };

  return (
    <>
      <ToolBar title={"비밀번호 변경"} height={TOOLBAR_HEIGHT} />
      <div
        style={{ marginTop: TOOLBAR_HEIGHT, paddingTop: 10, paddingBottom: 40 }}
      >
        <div
          style={{
            marginLeft: 16,
            fontSize: 14,
            marginBottom: 4,
            marginTop: 10,
          }}
        >
          새 비밀번호
        </div>
        <input
          type={"password"}
          onChange={(e) => {
            setNewPW1(e.target.value);
          }}
          style={{
            marginLeft: 10,
            borderRadius: 6,
            textAlign: "center",
            width: "calc(100% - 20px)",
            background: "#EEE",
            height: 50,
          }}
        />
        <div
          style={{
            marginLeft: 16,
            fontSize: 14,
            marginBottom: 4,
            marginTop: 10,
          }}
        >
          재입력
        </div>
        <input
          type={"password"}
          onChange={(e) => {
            setNewPW2(e.target.value);
          }}
          style={{
            marginLeft: 10,
            borderRadius: 6,
            textAlign: "center",
            width: "calc(100% - 20px)",
            background: "#EEE",
            height: 50,
          }}
        />
        <button
          style={{
            marginTop: 40,
            marginLeft: 10,
            borderRadius: 6,
            textAlign: "center",
            width: "calc(100% - 20px)",
            background: "#DDD",
            height: 50,
            lineHeight: 3,
          }}
          onClick={() => submit()}
        >
          비밀번호 변경
        </button>
      </div>
    </>
  );
}
