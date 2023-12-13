"use server";
import ToolBar from "./components/ToolBar";
import React from "react";
import CommentFab from "./components/CommentFab";
import { PrismaClient } from "@prisma/client";

export default async function Comic({ searchParams }: { searchParams: any }) {
  const TOOLBAR_HEIGHT = 70;

  //todo: DB 연결
  const title = "에피소드 ID : " + searchParams.id;
  // const comments = [
  //   { id: 1, replier_name: "작성자", text: "댓글 내용" },
  //   { id: 2, replier_name: "익명", text: "ㅋㅋㅋㅋㅋㅋ" },
  //   { id: 3, replier_name: "닌텐도", text: "스위치" },
  //   { id: 4, replier_name: "닌텐도", text: "스위치" },
  //   { id: 5, replier_name: "닌텐도", text: "스위치" },
  //   { id: 6, replier_name: "닌텐도", text: "스위치" },
  //   { id: 7, replier_name: "닌텐도", text: "스위치" },
  //   { id: 8, replier_name: "닌텐도", text: "스위치" },
  //   { id: 9, replier_name: "닌텐도", text: "스위치" },
  // ];

  const prisma = new PrismaClient();
  const episodeImages = await prisma.episodesImage.findMany({
    where: {
      EpisodeID: Number(searchParams.id),
    },
    orderBy: [{ CutNumber: "asc" }],
  });
  const comments = await prisma.commentsWithUserInfo.findMany({
    where: {
      EpisodeID: Number(searchParams.id),
    },
    orderBy: [{ Timestamp: "asc" }],
  });
  prisma.$disconnect();

  return (
    <>
      <ToolBar title={title} height={TOOLBAR_HEIGHT} />

      <div style={{ paddingTop: TOOLBAR_HEIGHT, background: "white" }}>
        {episodeImages.map((item, index) => (
          <img
            key={index}
            src={item.ImageURL ?? ""}
            alt={""}
            width={"100%"}
            style={{ objectFit: "cover" }}
          />
        ))}
      </div>

      <CommentFab comments={comments} />
    </>
  );
}
