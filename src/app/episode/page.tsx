'use client'
import ToolBar from "./components/ToolBar";
import React from "react";
import {useSearchParams} from "next/navigation";
import CommentFab from "./components/CommentFab";

export default function Comic() {
    const TOOLBAR_HEIGHT = 70
    const params = useSearchParams()

    //todo: DB 연결
    const title = "에피소드 ID : " + params.get("id")
    const images = [
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
        "https://source.unsplash.com/1920x1080",
    ]
    const comments = [
        {id:1, replier_name: "작성자", text: "댓글 내용"},
        {id:2, replier_name: "익명", text: "ㅋㅋㅋㅋㅋㅋ"},
        {id:3, replier_name: "닌텐도", text: "스위치"},
        {id:4, replier_name: "닌텐도", text: "스위치"},
        {id:5, replier_name: "닌텐도", text: "스위치"},
        {id:6, replier_name: "닌텐도", text: "스위치"},
        {id:7, replier_name: "닌텐도", text: "스위치"},
        {id:8, replier_name: "닌텐도", text: "스위치"},
        {id:9, replier_name: "닌텐도", text: "스위치"},
    ]

    return (
        <>
            <ToolBar title={title} height={TOOLBAR_HEIGHT}/>

            <div style={{paddingTop: TOOLBAR_HEIGHT, background: "white"}}>
                {images.map((item, index) => <img key={index} src={item} alt={""} width={"100%"} style={{objectFit: "cover"}}/>)}
            </div>

            <CommentFab comments={comments}/>
        </>)
}