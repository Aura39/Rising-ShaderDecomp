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
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r1.xy = float2(0.5, -0.5);
	r0.xy = r0.xy * r1.xy + g_TargetUvParam.xy;
	r0.xy = r0.xy + 0.5;
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
