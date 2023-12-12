"use client";
import React from "react";
import {useRouter} from "next/navigation";
import ComicIcon from "../../icons/ComicIcon";
import Link from "next/link";

export default function ToolBar({title = "", height = 50}) {
    const router = useRouter();

    return (
        <div style={{
            background: "#FFFFFFA0",
            backdropFilter: "blur(20px)",
            WebkitBackdropFilter: "blur(20px)",
            width: "100%",
            height: height,
            position: "fixed",
            left: 0,
            top: 0,
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
        }}>
            <div style={{display: "flex", justifyContent: "start", alignItems: "center"}}>
                <div style={{margin: "6px 14px 6px 20px",}}>
                    <ComicIcon/>
                </div>
                <span style={{color: "black", fontWeight: 600}}>{title}</span>
            </div>
            <div style={{display: "flex", justifyContent: "start", alignItems: "center"}}>
                <div style={{margin: 20, borderRadius: 1000}}>
                    <Link href={"/login"}><span style={{fontWeight: 600}}>로그인</span></Link>
                </div>
            </div>
        </div>
    );
}
