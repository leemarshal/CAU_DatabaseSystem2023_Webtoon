"use client";
import React from "react";
import ArrowLeftIcon from "../../icons/ArrowLeftIcon";
import { useRouter } from "next/navigation";
import ComicIcon from "../../icons/ComicIcon";

export default function ToolBar({ title = "", height = 50 }) {
  const router = useRouter();

  return (
    <div
      style={{
        background: "#FFFFFFA0",
        backdropFilter: "blur(20px)",
        width: "100%",
        height: height,
        position: "fixed",
        left: 0,
        top: 0,
        display: "flex",
        justifyContent: "start",
        alignItems: "center",
      }}
    >
      <ComicIcon
        props={{
          style: {
            fill: "#000",
            width: 40,
            height: "100%",
            margin: "6px 14px 6px 20px",
          },
        }}
      />
      <span style={{ color: "black", fontWeight: 600 }}>{title}</span>
    </div>
  );
}
