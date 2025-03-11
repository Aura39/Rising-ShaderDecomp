float4 g_CameraParam : register(c193);
float4x4 g_Proj : register(c4);

float4 main(float4 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0.x = 1 / texcoord.w;
	r0.x = r0.x * texcoord.z;
	r0.x = r0.x + transpose(g_Proj)[2].z;
	r0.x = 1 / r0.x;
	r0.w = transpose(g_Proj)[2].w;
	r0.x = r0.w * r0.x + -g_CameraParam.x;
	r0.y = 1 / g_CameraParam.y;
	o = r0.y * r0.x;

	return o;
}
