'use client'
import React, {useState} from "react";
import CommentIcon from "../../icons/CommentIcon";
import CommentItem from "./CommentItem";

export default function CommentFab({comments = [{id:"", replier_name:"", text:"",}]}) {
    const [fabScale, setFabScale] = useState(1)
    const [isCommentPopupOpen, setCommentPopupOpen] = useState(false)

    return (
        <>
            <div style={{
                position: "fixed",
                top: 0,
                left: 0,
                background: isCommentPopupOpen ? "rgba(0,0,0,0.6)" : "rgba(0,0,0,0.0)",
                width: "100%",
                height: "100%",
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                pointerEvents: isCommentPopupOpen ? "all" : "none",
                zIndex: 1,
                transition: "background 0.3s"
            }} onClick={()=>setCommentPopupOpen(false)}>
                <div style={{
                    position: "fixed",
                    top: 0,
                    left: 20,
                    width: "calc(100% - 40px)",
                    height: "calc(100% - 240px)",
                    background:"white",
                    borderRadius: 14,
                    transform: isCommentPopupOpen ? "translate(0, 120px) scale(1)" : "translate(50%, 100%) scale(0.1)",
                    opacity: isCommentPopupOpen ? 1 : 0,
                    transition: "transform 0.3s, opacity 0.2s",
                    pointerEvents: isCommentPopupOpen ? "all" : "none",
                    zIndex: 2,
                    padding: 10,
                    overflow:"scroll"
                }} onClick={e=>e.stopPropagation()}>
                    {comments.map((item, index) =>
                        <CommentItem key={item.id} name={item.replier_name} text={item.text}/>
                    )}
                </div>
            </div>
            <div
                style={{
                    position: "fixed",
                    bottom: 20,
                    right: 20,
                    background: "white",
                    borderRadius: 1000,
                    width: 60,
                    height: 60,
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center",
                    transform: "scale(" + fabScale + ")",
                    transition: "transform 0.2s ease",
                    boxShadow:"1px 4px 20px rgba(0,0,0,0.4)"
                }}
                onMouseOver={() => setFabScale(1.1)}
                onMouseLeave={() => setFabScale(1.0)}
                onMouseDown={() => setFabScale(0.9)}
                onMouseUp={() => setFabScale(1.0)}
                onClick={() => setCommentPopupOpen(true)}
            >
                <CommentIcon/>
            </div>
        </>
    )
}