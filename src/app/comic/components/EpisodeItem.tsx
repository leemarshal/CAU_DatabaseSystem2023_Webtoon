import React from "react";
import Link from "next/link";

export default function EpisodeItem({
  title = "",
  thumb = "",
  height = 50,
  path = "",
}: {
  title: string | null;
  thumb: string;
  height: number;
  path: string;
}) {
  return (
    <Link href={path}>
      <div
        style={{
          width: "100%",
          height: height,
          left: 0,
          top: 0,
          display: "flex",
          justifyContent: "start",
          alignItems: "center",
          cursor: "pointer",
          borderBottom: "1px solid rgba(0,0,0,0.1)",
        }}
      >
        <img
          src={thumb}
          alt={""}
          style={{
            borderRadius: 6,
            height: "calc(100% - 14px)",
            margin: "7px 14px 7px 20px",
            aspectRatio: 1,
            objectFit: "cover",
          }}
        />
        <span style={{ color: "black" }}>{title}</span>
      </div>
    </Link>
  );
}
