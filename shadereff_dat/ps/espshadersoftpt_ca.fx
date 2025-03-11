float4 g_CameraParam : register(c193);
float4 g_MatrialColor : register(c184);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_TargetUvParam : register(c194);

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
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0 = r0 * g_MatrialColor;
	r1.w = 1;
	r2 = r0.w * r1.w + -0.001;
	clip(r2);
	r2.xy = g_TargetUvParam.xy + i.texcoord1.xy;
	r2 = tex2D(g_Sampler1, r2);
	r2.x = r2.x * g_CameraParam.y + g_CameraParam.x;
	r2.x = r2.x + -i.texcoord1.w;
	r2.x = r2.x * g_Rate.x;
	r1.xyz = r2.xxx;
	r0 = r0 * r1;
	o = r0;

	return o;
}
