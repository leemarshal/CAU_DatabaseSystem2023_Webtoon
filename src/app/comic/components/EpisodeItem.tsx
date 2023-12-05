'use client'
import React from "react";
import {useRouter} from "next/navigation";

export default function EpisodeItem({title = "", thumb = "", height = 50, path = ""}) {
    const router = useRouter()

    return <div style={{
        width: "100%",
        height: height,
        left: 0,
        top: 0,
        display: "flex",
        justifyContent: "start",
        alignItems: "center",
        cursor: "pointer",
        borderBottom:"1px solid rgba(0,0,0,0.1)"
    }} onClick={() => router.push(path)}>

        <img src={thumb} alt={""}
             style={{borderRadius: 6, height: "calc(100% - 14px)", margin: "7px 14px 7px 20px", aspectRatio: 1, objectFit: "cover"}}/>
        <span style={{color: "black"}}>
            {title}
        </span>
    </div>
}