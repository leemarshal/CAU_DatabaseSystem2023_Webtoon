"use client";
import React from "react";
import ArrowLeftIcon from "../../icons/ArrowLeftIcon";
import { useRouter } from "next/navigation";
import Link from "next/link";

export default function ToolBar({ title = "", height = 50, liked = false }) {
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
        justifyContent: "space-between",
        alignItems: "center",
      }}
    >
      <div
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        <ArrowLeftIcon
          props={{
            style: {
              fill: "#000",
              width: 40,
              height: "100%",
              margin: "6px 6px 6px 20px",
              cursor: "pointer",
              padding: 10,
            },
          }}
          onClick={() => router.back()}
        />
        <span style={{ color: "black" }}>{title}</span>
      </div>
    </div>
  );
}
