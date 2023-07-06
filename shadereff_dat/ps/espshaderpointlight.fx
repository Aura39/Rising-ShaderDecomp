float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = i.texcoord1.y * 0.5 + 0.5;
	r0.z = -r0.x + g_TargetUvParam.y;
	r1.x = 0.5;
	r0.x = i.texcoord1.x * r1.x + g_TargetUvParam.x;
	r0.xy = r0.xz + float2(0.5, 1);
	r0 = tex2D(g_Sampler1, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord1.w;
	r0.y = 1 / g_Rate.x;
	r0.x = r0.y * abs(r0.x);
	r0.w = -r0.x + 1;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1 = r1 * g_MatrialColor;
	r2 = r1.w * r0.w + -0.001;
	clip(r2);
	r0.xyz = 1;
	r0 = r0 * r1;
	o = r0;

	return o;
}
