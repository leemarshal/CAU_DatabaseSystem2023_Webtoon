'use client'
import React, {useState} from "react";
import CommentIcon from "../../icons/CommentIcon";

export default function CommentItem({name="", text=""}) {
    return (
        <div style={{color:"black", padding: 10, borderBottom:"1px solid rgba(0,0,0,0.1)"}}>
            <span style={{display:"block", fontSize:12, marginLeft: 1, opacity:0.4, fontWeight: 600}}>{name}</span>
            <span style={{display:"block", fontSize:16, marginTop: 4}}>{text}</span>
        </div>
    )
}