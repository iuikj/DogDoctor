import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pathlib import Path

from app.database import create_tables
from routers import preprocess

BASE_DIR = Path(__file__).resolve().parent  # 指向 app/
STATIC_DIR = BASE_DIR / "static"            # 指向 app/static


app = FastAPI(
    title="Dog Doctor API",
    description="狗品种识别系统API",
    version="1.0.0"
)

# 配置CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 在生产环境中应该设置具体的源
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 挂载静态文件目录


app.mount("/static", StaticFiles(directory=STATIC_DIR), name="static")

# 导入路由
from app.routers import upload, train, predict

# 注册路由
app.include_router(upload.router, prefix="/api", tags=["上传"])
app.include_router(train.router, prefix="/api", tags=["训练"])
app.include_router(predict.router, prefix="/api", tags=["预测"])
# app.include_router(preprocess.router, prefix="/api", tags=["preprocess"])

@app.get("/")
async def root():
    return {"message": "欢迎使用Dog Doctor API"}
def main():
    print("=== DogDoctor API 启动中 ===")
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)

if __name__ == "__main__":
    create_tables()
    main()
