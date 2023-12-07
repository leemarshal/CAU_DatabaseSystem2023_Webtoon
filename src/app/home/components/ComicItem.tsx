import Link from "next/link";

export default function ComicItem({
  props,
}: {
  props: { image: string; title: string; path: string; width: string };
}) {
  if (!props) {
    return <div>존재하지 않는 웹툰</div>;
  }
  return (
    <Link href={props.path}>
      <div
        style={{
          display: "inline-block",
          padding: "1% 3% 1% 3%",
          width: props.width,
          cursor: "pointer",
        }}
      >
        <img
          src={props.image}
          style={{
            width: "100%",
            height: "100%",
            aspectRatio: 1,
            objectFit: "cover",
            borderRadius: 10,
          }}
        />
        <div
          style={{ textAlign: "center", margin: "8px 0 4px 0", color: "black" }}
        >
          {props.title}
        </div>
      </div>
    </Link>
  );
}
