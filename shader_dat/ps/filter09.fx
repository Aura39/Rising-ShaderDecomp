float4 g_RenderParam : register(c184);
sampler g_SamplerTexture : register(s0);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	r0.xy = -g_RenderParam.zw + texcoord.xy;
	r1.zw = r0.yy * float2(0.5, 1);
	r1.xy = g_RenderParam.zw + texcoord.xy;
	r2 = tex2Dlod(g_SamplerTexture, r1.xzww);
	r3 = tex2Dlod(g_SamplerTexture, r1.xyww);
	r0.z = r1.y;
	r1.x = dot(r3.xyz, 0.299);
	r1.y = dot(r2.xyz, 0.299);
	r1.y = r1.y + 0.001953125;
	r0.w = 0;
	r2 = tex2Dlod(g_SamplerTexture, r0.xzww);
	r0 = tex2Dlod(g_SamplerTexture, r0.xyww);
	r0.x = dot(r0.xyz, 0.299);
	r0.y = dot(r2.xyz, 0.299);
	r0.z = -r1.y + r0.y;
	r0.w = r0.z + -r0.x;
	r0.z = r0.z + r0.x;
	r2.y = r0.z + -r1.x;
	r2.x = r0.w + r1.x;
	r0.z = dot(r2.z, r2.z) + 0;
	r0.z = 1 / sqrt(r0.z);
	r0.zw = r0.zz * r2.xy;
	r1.z = min(abs(r0.w), abs(r0.z));
	r1.z = r1.z * 8;
	r1.z = 1 / r1.z;
	r1.zw = r0.zw * r1.zz;
	r2.xy = max(r1.zw, -2);
	r1.zw = min(r2.xy, 2);
	r2.x = 1 / g_RenderParam.x;
	r3.x = r2.x + r2.x;
	r2.z = 1 / g_RenderParam.y;
	r3.y = r2.z + r2.z;
	r2.xy = r2.xz * 0.5;
	r4.xy = r1.zw * -r3.xy + texcoord.xy;
	r3.xy = r1.zw * r3.xy + texcoord.xy;
	r4.zw = 0;
	r4 = tex2Dlod(g_SamplerTexture, r4);
	r4.w = dot(r4.xyz, 0.299);
	r3.zw = 0;
	r3 = tex2Dlod(g_SamplerTexture, r3);
	r3.w = dot(r3.xyz, 0.299);
	r3 = r3 + r4;
	r4.xy = r0.zw * -r2.xy + texcoord.xy;
	r2.xy = r0.zw * r2.xy + texcoord.xy;
	r4.zw = 0;
	r4 = tex2Dlod(g_SamplerTexture, r4);
	r4.w = dot(r4.xyz, 0.299);
	r2.zw = 0;
	r2 = tex2Dlod(g_SamplerTexture, r2);
	r2.w = dot(r2.xyz, 0.299);
	r2 = r2 + r4;
	r2 = r2 * 0.5;
	r3 = r3 * 0.5 + r2;
	r1.z = min(r0.y, r0.x);
	r1.w = max(r0.x, r0.y);
	r0.x = min(r1.x, r1.y);
	r0.y = max(r1.y, r1.x);
	r4.x = max(r1.w, r0.y);
	r4.y = min(r0.x, r1.z);
	r0.x = r3.w * 0.5 + -r4.y;
	r0.y = r3.w * -0.5 + r4.x;
	r1 = r3 * 0.5;
	r0.xy = (r0.xy >= 0) ? 0 : 1;
	r0.x = r0.y + r0.x;
	r0 = (-r0.x >= 0) ? r1 : r2;
	r1 = float4(1, 1, 0, 0) * texcoord.xyxx;
	r1 = tex2Dlod(g_SamplerTexture, r1);
	r1.w = dot(r1.xyz, 0.299);
	r2.x = min(r1.w, r4.y);
	r2.y = max(r4.x, r1.w);
	r2.x = -r2.x + r2.y;
	r2.x = r2.x * 2.5 + -r4.x;
	o = (r2.x >= 0) ? r0 : r1;

	return o;
}
