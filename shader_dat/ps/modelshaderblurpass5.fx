float4 g_CameraParam;
float4 g_DistParam;
sampler g_Sampler0;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler0, texcoord);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.xy = r0.xx + -g_DistParam.xz;
	r0.zw = -g_DistParam.xz + g_DistParam.yw;
	r0.z = 1 / r0.z;
	r0.w = 1 / r0.w;
	r0.xy = r0.zw * r0.xy;
	r0.x = -r0.x + 1;
	o = r0.y + r0.x;

	return o;
}
