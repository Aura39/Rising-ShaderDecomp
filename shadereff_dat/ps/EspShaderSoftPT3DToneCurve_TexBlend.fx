float4 g_BlendRate;
float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
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
	float4 r3;
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.y = r0.y * 0.5 + 0.5;
	r1.x = 0.5;
	r0.x = r0.x * r1.x + g_TargetUvParam.x;
	r0.z = -r0.y + g_TargetUvParam.y;
	r0.xy = r0.xz + float2(0.5, 1);
	r0 = tex2D(g_Sampler1, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord1.w;
	r0.x = r0.x * g_Rate.z;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r2 = tex2D(g_Sampler2, i.texcoord);
	r3 = lerp(r2, r1, g_BlendRate.x);
	r1 = r3.w * r0.x + -0.0001;
	r0.w = r0.x * r3.w;
	r0.xyz = g_Rate.yyy * r3.xyz + g_Rate.xxx;
	o = r0 * g_MatrialColor;
	clip(r1);

	return o;
}
