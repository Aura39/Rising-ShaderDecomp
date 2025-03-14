sampler g_Sampler0 : register(s0);
float4 g_TargetUvParam : register(c194);
float4 g_offsetPow : register(c184);
float2 pSampleOffset : register(c0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r1.x = g_offsetPow.x;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r2 = tex2D(g_Sampler0, r0.zwzw);
	r3 = tex2D(g_Sampler0, r0);
	r0.z = -r2.w + r3.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r2 = r0.z + r2;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r4 = tex2D(g_Sampler0, r0.zwzw);
	r0.z = r3.w + -r4.w;
	r0.z = abs(r0.z) + -g_offsetPow.y;
	r0.z = (r0.z >= 0) ? 1 : 0;
	r4 = r0.z + r4;
	r2 = r2 + r4;
	r0.zw = pSampleOffset.xy * r1.xx + r0.xy;
	r0.xy = pSampleOffset.xy * r1.xx + r0.xy;
	r1 = tex2D(g_Sampler0, r0);
	r0 = tex2D(g_Sampler0, r0.zwzw);
	r3.x = r3.w + -r0.w;
	r3.y = r3.w + -r1.w;
	r3.xy = abs(r3.xy) + -g_offsetPow.yy;
	r3.xy = (r3.xy >= 0) ? 1 : 0;
	r1 = r1 + r3.y;
	r0 = r0 + r3.x;
	r0 = r0 + r2;
	r0 = r1 + r0;
	o = r0 * 0.0833;

	return o;
}
