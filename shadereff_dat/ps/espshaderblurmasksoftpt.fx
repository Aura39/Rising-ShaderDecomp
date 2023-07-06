float4 g_Blur;
float4 g_CameraParam;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler1;
sampler g_Sampler2;
sampler g_Sampler3;
float4 g_TargetUvParam;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.x = 1 / i.texcoord.w;
	r0.xy = r0.xx * i.texcoord.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r1 = r0.xyxy + -g_Rate.xyxy;
	r2 = r1.zwzw * g_Blur.xxyy + r0.xyxy;
	r1 = r1 * g_Blur.zzww + r0.xyxy;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(g_Sampler3, r0);
	r0.x = r0.x * g_CameraParam.y + g_CameraParam.x;
	r0.x = r0.x + -i.texcoord.w;
	r0.x = r0.x * g_Rate.z;
	r3 = tex2D(g_Sampler1, r2);
	r2 = tex2D(g_Sampler1, r2.zwzw);
	r0.yzw = r2.xyz + r3.xyz;
	r2 = tex2D(g_Sampler1, r1);
	r1 = tex2D(g_Sampler1, r1.zwzw);
	r0.yzw = r0.yzw + r2.xyz;
	r0.yzw = r1.xyz + r0.yzw;
	r0.yzw = r0.yzw * g_MatrialColor.xyz;
	o.xyz = r0.yzw * 0.25;
	r1 = tex2D(g_Sampler2, i.texcoord1);
	r0.x = r0.x * r1.w;
	o.w = r0.x * g_MatrialColor.w;

	return o;
}
