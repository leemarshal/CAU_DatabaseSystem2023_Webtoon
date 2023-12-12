"use client";
import React, { useState } from "react";
import ComicIcon from "../../icons/ComicIcon";
import Link from "next/link";
import axios from "axios";
import { useRouter } from "next/navigation";

export default function ToolBar({
  title = "",
  height = 50,
  userName = "",
}: {
  title: string;
  height: number;
  userName: string | undefined;
}) {
  const router = useRouter();
  const [isUserMenuOpen, setUserMenuOpen] = useState(false);
  const logout = async () => {
    await axios.post("/api/logout");
    router.refresh();
  };

  return (
    <>
      <div
        style={{
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
          overflow: "hidden",
        }}
        onMouseLeave={() => {
          setUserMenuOpen(false);
        }}
      >
        <div
          style={{
            display: "flex",
            justifyContent: "start",
            alignItems: "center",
            transform: isUserMenuOpen ? "translateX(-100px)" : "",
            opacity: isUserMenuOpen ? 0 : 1,
            transition: "transform 0.3s ease, opacity 0.3s",
          }}
        >
          <div style={{ margin: "6px 14px 6px 20px" }}>
            <ComicIcon />
          </div>
          <span style={{ color: "black", fontWeight: 600 }}>{title}</span>
        </div>
        <div
          style={{
            display: "flex",
            justifyContent: "start",
            alignItems: "center",
          }}
          onMouseOver={(e) => {
            if (userName) {
              setUserMenuOpen(true);
              e.stopPropagation();
            }
          }}
        >
          <div style={{ margin: 20, borderRadius: 1000 }}>
            {userName ? (
              <>
                <div
                  style={{
                    position: "absolute",
                    top: 10,
                    right: 20,
                    height: height - 20,
                    background: "white",
                    display: "flex",
                    justifyContent: "center",
                    alignItems: "center",
                    transform: isUserMenuOpen ? "" : "translateX(120px)",
                    opacity: isUserMenuOpen ? 1 : 0,
                    transition: "transform 0.25s ease, opacity 0.35s",
                    pointerEvents: isUserMenuOpen ? "all" : "none",
                  }}
                >
                  <span
                    style={{ margin: 10, cursor: "pointer" }}
                    onClick={logout}
                  >
                    로그아웃
                  </span>
                  <Link href={"/changePW"}>
                    <span style={{ margin: 10, cursor: "pointer" }}>
                      비밀번호 변경
                    </span>
                  </Link>
                  <Link href={"/cookie"}>
                    <span style={{ margin: 10, cursor: "pointer" }}>
                      쿠키 구매
                    </span>
                  </Link>
                </div>
                <span style={{ cursor: "default" }}>{userName} 님</span>
              </>
            ) : (
              <Link href={"/login"}>
                <span style={{ fontWeight: 600 }}>로그인</span>
              </Link>
            )}
          </div>
        </div>
      </div>
    </>
  );
}
