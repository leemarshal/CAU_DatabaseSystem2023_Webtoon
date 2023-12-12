"use server";
import React from "react";
import ToolBar from "./home/components/ToolBar";
import SectionTitleBar from "./home/components/SectionTitleBar";
import HorizontalComicList from "./home/components/HorizontalComicList";
import VerticalComicList from "./home/components/VerticalComicList";
import { PrismaClient } from "@prisma/client";
import { cookies } from "next/headers";
import { userFromToken } from "@/func/userFromToken";

export default async function Page() {
  const TOOLBAR_HEIGHT = 70;

  //todo: DB 연결
  const comics = [
    { id: 1, title: "Test", thumb: "https://source.unsplash.com/500x500" },
    { id: 2, title: "Test", thumb: "https://source.unsplash.com/500x500" },
    { id: 3, title: "Test", thumb: "https://source.unsplash.com/500x500" },
    { id: 4, title: "Test", thumb: "https://source.unsplash.com/500x500" },
  ];

  const prisma = new PrismaClient();
  const webtoons = await prisma.webtoons.findMany();

  let user, token;
  token = cookies().get("token");
  if (token) {
    user = await userFromToken(token.value);
  }

  return (
    <>
      <ToolBar
        title={"웹툰 서비스 데모"}
        height={TOOLBAR_HEIGHT}
        userName={user?.Username ?? undefined}
      />
      <div style={{ paddingTop: TOOLBAR_HEIGHT, background: "white" }}>
        <SectionTitleBar title={"전체웹툰"} description={"설명"} />
        <HorizontalComicList props={{ comicList: webtoons }} />
        <SectionTitleBar title={"오늘 연재"} description={"설명"} />
        <VerticalComicList props={{ comicList: webtoons }} />
      </div>
    </>
  );
}
