'use client'
import ToolBar from "@/app/cookie/components/ToolBar";
import {useState} from "react";

export default function ChangePW() {
    const TOOLBAR_HEIGHT = 70;
    const [newPW1, setNewPW1] = useState("")
    const [newPW2, setNewPW2] = useState("")

    const submit = () => {
        if (!newPW1 || !newPW2) {
            alert("비밀번호를 입력하세요.")
        } else if (newPW1 !== newPW2) {
            alert("비밀번호가 일치하지 않습니다.")
        } else {
            //todo: 여기서 비번 업데이트
        }
    }

    return (
        <>
            <ToolBar title={"비밀번호 변경"} height={TOOLBAR_HEIGHT}/>
            <div style={{marginTop: TOOLBAR_HEIGHT, paddingTop: 10, paddingBottom: 40}}>
                <div style={{marginLeft: 16, fontSize: 14, marginBottom: 4, marginTop: 10}}>새 비밀번호</div>
                <input type={"password"} onChange={(e) => {
                    setNewPW1(e.target.value)
                }} style={{
                    marginLeft: 10,
                    borderRadius: 6,
                    textAlign: "center",
                    width: "calc(100% - 20px)",
                    background: "#EEE",
                    height: 50
                }}/>
                <div style={{marginLeft: 16, fontSize: 14, marginBottom: 4, marginTop: 10}}>재입력</div>
                <input type={"password"} onChange={(e) => {
                    setNewPW2(e.target.value)
                }} style={{
                    marginLeft: 10,
                    borderRadius: 6,
                    textAlign: "center",
                    width: "calc(100% - 20px)",
                    background: "#EEE",
                    height: 50
                }}/>
                <button style={{
                    marginTop: 40,
                    marginLeft: 10,
                    borderRadius: 6,
                    textAlign: "center",
                    width: "calc(100% - 20px)",
                    background: "#DDD",
                    height: 50,
                    lineHeight: 3
                }} onClick={() => submit()}>비밀번호 변경
                </button>
            </div>
        </>
    )
}